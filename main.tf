# Create vpc
module "vpc_prod" {
  source       = "./modules/vpc"
  network_name = var.vpc_configs.prod.network_name
  subnets      = var.vpc_configs.prod.subnets
}

