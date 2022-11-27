locals {
  product           = "beta"
  rds_instance_name = "db-proj-${local.product}"
  bucket_name       = "s3-proj-${local.product}"
  region            = var.AWS_REGION
  tags              = {
    Name = "proj-${local.product}"
  }
}

module "s3_beta" {
  source       = "../../modules/product-s3"
  product_name = local.product
  bucket_name  = local.bucket_name
}

module "rds_beta" {
  source                 = "../../modules/product-rds"
  identifier             = local.rds_instance_name
  engine                 = "mysql"
  engine_version         = "8.0.30"
  allocated_storage      = "5"
  subnet_ids             = module.vpc.database_subnets
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  family                 = "mysql8.0"
  parameters             = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}

################################################################################
# Create the supporting VPC, database subnet and security group resources
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                         = "vpc-${local.product}"
  cidr                         = "10.1.0.0/16"
  azs                          = ["${local.region}a", "${local.region}b"]
  public_subnets               = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets              = ["10.1.3.0/24", "10.1.4.0/24"]
  database_subnets             = ["10.1.5.0/24", "10.1.6.0/24"]
  create_database_subnet_group = true
  tags                         = local.tags
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "rds-sg-${local.rds_instance_name}"
  description = "DB ${local.rds_instance_name} security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
  tags = local.tags
}
