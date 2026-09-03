data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name          = "k6-instance"
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "c6i.xlarge"
  key_name      = var.key_name != "" ? var.key_name : null
  subnet_id     = var.subnet_id

  iam_instance_profile = aws_iam_instance_profile.k6.name

  vpc_security_group_ids = [aws_security_group.k6.id]

  create_eip = true

  user_data_base64 = base64encode(<<-EOF
    #!/bin/bash
    set -e
    dnf install -y git jq python3 unzip

    dnf install -y https://dl.k6.io/rpm/repo.rpm
    dnf install -y k6
    
    curl -sSL -o /tmp/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v3.13.2/prometheus-3.13.2.linux-amd64.tar.gz
    tar -xzf /tmp/prometheus.tar.gz -C /tmp
    install -m 0755 /tmp/prometheus-3.13.2.linux-amd64/promtool /usr/local/bin/promtool
    rm -rf /tmp/prometheus.tar.gz /tmp/prometheus-3.13.2.linux-amd64
    EOF
  )
}

resource "aws_iam_role" "k6" {
  name = "k6-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_instance_profile" "k6" {
  name = "k6-instance-profile"
  role = aws_iam_role.k6.name
}

resource "aws_iam_role_policy_attachment" "k6_ssm" {
  role       = aws_iam_role.k6.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_security_group" "k6" {
  name        = "k6-sg"
  description = "Security group for k6"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH with admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    description = "HTTPS to internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP to ALB in VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "DNS UDP"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "DNS TCP"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
