## Scenario 1

We will automate the creation of AWS S3 buckets amd AWS RDS instances for the products.

For product Alpha, create S3 bucket with bucket name "s3-proj-alpha" and RDS instance with instance name "rds-proj-alpha".

For product Beta, create S3 bucket with bucket name "s3-proj-beta" and RDS instance with instance name "rds-proj-beta".

> **_NOTE:_**  We have to use hypen (-) instead of underscore (_) in the bucket name and instance name 
> because both names cannot contain underscore.

### Directories & Files

* [README.md](README.md)
* [modules/](modules)
  * [product-rds/](modules/product-rds)
    * [README.md](modules/product-rds/README.md)
    * [main.tf](modules/product-rds/main.tf)
    * [variables.tf](modules/product-rds/variables.tf)
    * [outputs.tf](modules/product-rds/outputs.tf)
    * [versions.tf](modules/product-rds/versions.tf)
  * [product-s3/](modules/product-s3)
    * [README.md](modules/product-s3/README.md)
    * [main.tf](modules/product-s3/main.tf)
    * [variables.tf](modules/product-s3/variables.tf)
    * [outputs.tf](modules/product-s3/outputs.tf)
    * [versions.tf](modules/product-s3/versions.tf)
* [products/](products)
  * [alpha/](products/alpha)
    * [README.md](products/alpha/README.md)
    * [main.tf](products/alpha/main.tf)
    * [variables.tf](products/alpha/variables.tf)
    * [outputs.tf](products/alpha/outputs.tf)
    * [versions.tf](products/alpha/versions.tf)
  * [beta/](products/beta)
    * [README.md](products/beta/README.md)
    * [main.tf](products/beta/main.tf)
    * [variables.tf](products/beta/variables.tf)
    * [outputs.tf](products/beta/outputs.tf)
    * [versions.tf](products/beta/versions.tf)

To increase the code re-usability and modularity, the provisioning of the S3 bucket and RDS instance are
in local modules [product-rds](modules/product-rds/README.md) and [product-s3](modules/product-s3/README.md).

The 2 local modules are located in the [modules](modules) directory.

Each product will have its own directory under the [products](products) directory.

