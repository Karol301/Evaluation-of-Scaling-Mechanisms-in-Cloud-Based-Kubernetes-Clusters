variable "aws_region" {
  type        = string
  description = "AWS region for all resources"
  default     = "eu-central-1"
}

variable "ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH into the k6 instance (your public IP, e.g. 1.2.3.4/32)"
}

variable "key_name" {
  type        = string
  description = "Name of an existing EC2 key pair in the region; empty string means no SSH key (access over SSM)"
  default     = ""
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "latency-scale"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for EKS; must be in standard support, otherwise AWS rejects cluster creation"
  default     = "1.35"
}
