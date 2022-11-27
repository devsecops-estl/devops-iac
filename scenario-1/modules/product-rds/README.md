# Product RDS Terraform module

Terraform module which creates RDS resources for products according to the hardening guidelines. It uses the
[AWS RDS Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)
to create the RDS resources.

**The following best practices are enforced for RDS instance**

1. Master password for the database must be randomly generated.
2. Backups must be enabled and retained for 7 days.
3. Delete protection must be enabled.
4. Minor engine upgrades will be applied automatically to the DB instance.
5. Instance must not be publicly accessible.

## Files

1. **[main.tf](main.tf)** – contains the main code.
2. **[variables.tf](variables.tf)** – contains the input variables which are customizable and defined inside the
   main.tf configuration file.
3. **[outputs.tf](outputs.tf)** : contains the output parameters to display after Terraform has been executed that is
   after terraform apply command.
4. **[versions.tf](versions.tf)** - declare the dependencies and versions of the providers.

## Usage

```hcl
module "rds_alpha" {
  source                 = "../../modules/product-rds"
  identifier             = "db-proj-alpha"
  engine                 = "mysql"
  engine_version         = "8.0.30"
  allocated_storage      = "5"
  subnet_ids             = ["subnet-0fdf1206b89187429", "subnet-0144b0bfec542a59f"]
  db_subnet_group_name   = "vpc-db-proj-alpha"
  vpc_security_group_ids = ["sg-0798f621ed94767c5"]
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
```

## Requirements

| Name      | Version     |
|-----------|-------------|
| terraform | &gt;= 1.3.0 |
| aws       | &gt;= 4.28  |
| random    | &gt;= 3.1   |

## Providers

| Name   | Version    |
|--------|------------|
| aws    | &gt;= 4.28 |
| random | &gt;= 3.1  |

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name                    | Description                                                                                | Type           | Default           | Required |
|-------------------------|--------------------------------------------------------------------------------------------|----------------|-------------------|:--------:|
| identifier              | The name of the RD instance                                                                | `string`       | n/a               |   yes    |
| allocated_storage       | The allocated storage in gibibytes                                                         | `string`       | n/a               |   yes    |
| engine                  | The database engine to use                                                                 | `string`       | n/a               |   yes    |
| engine_version          | The engine version to use                                                                  | `string`       | n/a               |   yes    |
| instance_class          | The instance type of the RDS instance                                                      | `string`       | `db.t3.micro`     |    no    | 
| db_name                 | The DB name to create. If omitted, no database is created initially                        | `string`       | `null`            |    no    | 
| username                | Username for the master DB user                                                            | `string`       | `admin`           |    no    |
| port                    | The port on which the DB accepts connections                                               | `number`       | `null`            |    no    |
| vpdc_security_group_ids | A list of security group IDs to associate with the RDS instance                            | `list(string)` | n/a               |   yes    |
| availability_zone       | The AZ for the RDS instance                                                                | `string`       | `ap-southeast-1a` |    no    |
| db_subnet_group_name    | The DB subnet group name to use for the RDS instance                                       | `string`       | n/a               |   yes    |
| subnet_ids              | A list of VPC subnet IDs                                                                   | `list(string)` | n/a               |   yes    |
| family                  | The family of the DB parameter group                                                       | `string`       | `null`            |    no    |
| parameters              | A list of DB parameters to apply                                                           | `list(object)` | `[]`              |    no    |
| major_engine_version    | Specifies the major version of the engine that this option group should be associated with | `string`       | `null`            |    no    |
| options                 | A list of Options to apply                                                                 | `list(object)` | `[]`              |    no    |

## Outputs

| Name                              | Description                                                                             |
|-----------------------------------|-----------------------------------------------------------------------------------------|
| db_instance_address               | The address of the RDS instance                                                         |
| db_instance_arn                   | The ARN of the RDS instance                                                             |
| db_instance_availability_zone     | The availability zone of the RDS instance                                               |
| db_instance_endpoint              | The connection endpoint                                                                 |
| db_instance_engine                | The database engine type                                                                |
| db_instance_engine_version_actual | The running version of the database                                                     |
| db_instance_hosted_zone_id        | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| db_instance_id                    | The RDS instance ID                                                                     |
| db_instance_resource_id           | The RDS resource ID of this instance                                                    |
| db_instance_status                | The RDS instance status                                                                 |
| db_instance_name                  | The database name                                                                       |
| db_instance_username              | The master username for the database                                                    |
| db_instance_port                  | The database port                                                                       |
| db_instance_ca_cert_identifier    | Specifies the identifier of the CA certificate for the DB instance                      |
| db_instance_domain                | The ID of the Directory Service Active Directory domain the instance is joined to       |
| db_instance_domain_iam_role_name  | The name of the IAM role to be used when making API calls to the Directory Service      |
| db_instance_password              | The password for the master DB user                                                     |
