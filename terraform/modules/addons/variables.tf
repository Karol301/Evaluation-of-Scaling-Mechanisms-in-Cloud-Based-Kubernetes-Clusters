variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID - the ALB controller discovers subnets inside it by tags"
}

variable "aws_region" {
  type        = string
  description = "AWS region passed to the ALB controller"
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN of the cluster OIDC provider (output of the eks module) - the basis for IRSA"
}
