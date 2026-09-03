output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "IDs of the private subnets (EKS nodes)"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "IDs of the public subnets (k6 instance, ALB, NAT gateway)"
  value       = module.vpc.public_subnets
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}
