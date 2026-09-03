output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "update_kubeconfig_command" {
  description = "Command that points the local kubeconfig at this cluster"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}

output "ec2_k6_public_ip" {
  description = "Public IP (EIP) of the k6 load generator instance"
  value       = module.ec2_k6.public_ip
}

output "alb_controller_role_arn" {
  description = "ARN of the IRSA role used by aws-load-balancer-controller"
  value       = module.addons.alb_controller_role_arn
}

output "grafana_admin_password" {
  description = "Grafana admin password (username: admin)"
  value       = module.addons.grafana_password
  sensitive   = true
}
