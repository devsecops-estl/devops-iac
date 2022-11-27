## Scenario 2

We will automate the creation of a list of users, along with their roles and products they are working
on as shown below.

| User Name | Role      | Product Team   |
|-----------|-----------|----------------|
| Alice     | Developer | Alpha<br>Gamma |
| Bob       | QA        | Beta           |
| Michael   | Developer | Beta           |
| Mike      | QA        | Beta<br>Gamma  |
| Terry     | Developer | Gamma          |
| John      | QA        | Alpha          |

A group will be created for each product team. For example, group "Alpha", "Beta", etc.

The automation consists of

1. Create users.
2. Create groups.
3. Add policies to groups. Each group will have policies that allows the product teams to access the resources
   associated with the product. ***In this assessment, we will assign the same policy, AmazonEC2FullAccess,
   to all the groups***.
4. Add users to groups.
5. Create roles.
6. Add policies specific to roles. ***In this assessment, we will assign the same policy to all the roles***.

## Files

1. **[main.tf](main.tf)** – contains the main code.
2. **[variables.tf](variables.tf)** – contains the input variables which are customizable and defined inside the
   main.tf configuration file.
3. **[outputs.tf](outputs.tf)** : contains the output parameters to display after Terraform has been executed that is
   after terraform apply command.
4. **[versions.tf](versions.tf)** - declare the dependencies and versions of the providers.
5. **[providers.tf](providers.tf)** – define the terraform providers such as terraform aws provider, terraform azure
   provider etc to authenticate with the cloud provider.
6. **[users.json](users.json)** - contain a list of users to be created with associated role and groups.

## Usage

Define a list of users in the file [users.json](users.json).

```json
[
   {
      "name": "Alice",
      "role": "Developer",
      "groups": [
         "Alpha",
         "Gamma"
      ]
   },
   {
      "name": "Bob",
      "role": "QA",
      "groups": [
         "Beta"
      ]
   },
   {
      "name": "Michael",
      "role": "Developer",
      "groups": [
         "Beta"
      ]
   },
   {
      "name": "Mike",
      "role": "QA",
      "groups": [
         "Beta",
         "Gamma"
      ]
   },
   {
      "name": "Terry",
      "role": "Developer",
      "groups": [
         "Gamma"
      ]
   },
   {
      "name": "John",
      "role": "QA",
      "groups": [
         "Alpha"
      ]
   }
]
```
