# Product S3 Terraform module

Terraform module which creates S3 resources for products according to the hardening guidelines. It uses the
[AWS S3 Terraform module](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket)
to create the S3 resources.

**The following best practices are enforced for each S3 bucket**

1. Server-side encryption (AES256) is enabled.
2. Bucket policies only allow HTTPS requests and TLS version must be at least 1.2.
3. Bucket is blocked from public access.
4. Bucket versioning is enabled.

## Files

1. **[main.tf](main.tf)** – contains the main code.
2. **[variables.tf](variables.tf)** – contains the input variables which are customizable and defined inside the
   main.tf configuration file.
3. **[outputs.tf](outputs.tf)** : contains the output parameters to display after Terraform has been executed that is
   after terraform apply command.
4. **[versions.tf](versions.tf)** - declare the dependencies and versions of the providers.

## Usage

```hcl
module "s3_alpha" {
  source       = "../../modules/product-s3"
  product_name = "alpha"
  bucket_name  = "s3-proj-alpha"
}
```
> **_NOTE:_**  We have to use hypen (-) instead of underscore (_) in the bucket name as the bucket name 
> cannot contain underscore.

## Requirements

| Name      | Version     |
|-----------|-------------|
| terraform | &gt;= 1.3.0 |
| aws       | &gt;= 4.28  |

## Providers

| Name | Version    |
|------|------------|
| aws  | &gt;= 4.28 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                  | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                           | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy)                                                             | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                                                                   | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                     | resource |

## Inputs

| Name         | Description             | Type     | Default | Required |
|--------------|-------------------------|----------|---------|:--------:|
| product_name | The name of the product | `string` | n/a     |   yes    |
| bucket_name  | The name of the bucket  | `string` | n/a     |   yes    |

## Outputs

| Name                                  | Description                                                           |
|---------------------------------------|-----------------------------------------------------------------------|
| s3_bucket_id                          | The name of the bucket                                                |
| s3_bucket_arn                         | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname      |
| s3_bucket_bucket_domain_name          | The bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| s3_bucket_bucket_regional_domain_name | The bucket region-specific domain name                                |
| s3_bucket_hosted_zone_id              | The Route 53 Hosted Zone ID for this bucket's region                  |
| s3_bucket_region                      | The AWS region this bucket resides in                                 |
