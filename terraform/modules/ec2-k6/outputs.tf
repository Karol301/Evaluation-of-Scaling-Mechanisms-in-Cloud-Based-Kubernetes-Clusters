output "public_ip" {
  description = "Public IP (EIP) of the k6 instance"
  value       = module.ec2_instance.public_ip
}
