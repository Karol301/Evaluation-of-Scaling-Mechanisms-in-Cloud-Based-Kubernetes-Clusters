output "grafana_password" {
  description = "Generated Grafana admin password"
  value       = random_password.grafana.result
  sensitive   = true
}

output "alb_controller_role_arn" {
  description = "ARN of the IRSA role used by aws-load-balancer-controller"
  value       = module.alb_controller_irsa.iam_role_arn
}
