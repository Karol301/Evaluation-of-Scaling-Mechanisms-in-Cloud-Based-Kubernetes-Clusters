module "vpc" {
  source = "./modules/vpc"

  cluster_name = var.cluster_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
}

module "ec2_k6" {
  source = "./modules/ec2-k6"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  vpc_cidr  = module.vpc.vpc_cidr_block
  ssh_cidr  = var.ssh_cidr
  key_name  = var.key_name
}

module "addons" {
  source = "./modules/addons"

  cluster_name      = module.eks.cluster_name
  vpc_id            = module.vpc.vpc_id
  aws_region        = var.aws_region
  oidc_provider_arn = module.eks.oidc_provider_arn

  depends_on = [module.eks]
}
