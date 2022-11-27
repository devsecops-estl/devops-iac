locals {
  create_db_parameter_group = (length(var.parameters) == 0 || var.family == null) ? false : true
  create_db_option_group = (length(var.options) == 0 || var.major_engine_version == null) ? false : true
}

module "db" {
  source = "terraform-aws-modules/rds/aws"
  # instance identifier can only contain alphanumeric characters and hyphens
  identifier                 = var.identifier
  # DB name can only contain alphanumeric characters and underscores
  db_name                    = var.db_name
  username                   = var.username
  engine                     = var.engine
  engine_version             = var.engine_version
  port                       = var.port
  instance_class             = var.instance_class
  allocated_storage          = var.allocated_storage
  create_random_password     = true
  availability_zone          = var.availability_zone
  #  todo - set multi_az to true
  multi_az                   = false
  publicly_accessible        = false
  auto_minor_version_upgrade = true
  #  todo - set deletion_protection to true
  deletion_protection        = false
  backup_retention_period    = 7
  vpc_security_group_ids     = var.vpc_security_group_ids

  create_db_subnet_group     = false
  db_subnet_group_name       = var.db_subnet_group_name
  subnet_ids                 = var.subnet_ids

  family                     = var.family
  parameters                 = var.parameters

  create_db_option_group     = local.create_db_option_group
  major_engine_version       = var.major_engine_version
  options                    = var.options
}
