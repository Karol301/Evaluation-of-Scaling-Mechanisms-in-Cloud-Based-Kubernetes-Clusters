variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the control plane and the node groups"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC the cluster is created in"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for the control plane ENIs and the node groups"
}
