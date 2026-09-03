module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  enable_irsa                              = true
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2023_x86_64_STANDARD"
  }

  eks_managed_node_groups = {
    app = {
      name           = "worker-group-app"
      instance_types = ["c6i.large"]

      min_size     = 3
      max_size     = 3
      desired_size = 3

      labels = { role = "app" }

      taints = {
        app_only = {
          key    = "workload"
          value  = "app"
          effect = "NO_SCHEDULE"
        }
      }
    }

    monitoring = {
      name = "worker-group-mon"

      instance_types = ["m6i.xlarge"]

      min_size     = 1
      max_size     = 1
      desired_size = 1

      labels = { role = "monitoring" }
    }
  }
}
