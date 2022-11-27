# Product Alpha

This directory contains the Terraform code for provisioning the `alpha` product AWS resource.

## Files

1. **[main.tf](main.tf)** – contains the main code.
2. **[variables.tf](variables.tf)** – contains the input variables which are customizable and defined inside the
   main.tf configuration file.
3. **[outputs.tf](outputs.tf)** : contains the output parameters to display after Terraform has been executed that is
   after terraform apply command.
4. **[versions.tf](versions.tf)** - declare the dependencies and versions of the providers.
5. **[providers.tf](providers.tf)** – define the terraform providers such as terraform aws provider, terraform azure
   provider etc to authenticate with the cloud provider.

> **_NOTE:_**  The creation of the supporting VPC, database subnet and security group resources are for 
> completeness. If they already exist, pass in the existing name or id.
