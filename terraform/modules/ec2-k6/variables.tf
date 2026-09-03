variable "key_name" {
  type        = string
  description = "Name of an existing EC2 key pair"
}

variable "subnet_id" {
  type        = string
  description = "Public subnet ID the k6 instance is placed in"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC the security group is created in"
}

variable "ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH into the instance"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block - egress target for test traffic to the ALB"
}
