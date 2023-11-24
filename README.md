# terraform-azure-mssql-db
# Terraform Azure Infrastructure

This Terraform configuration defines an Azure infrastructure using the Azure provider.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This repository contains Terraform code to deploy resources on Microsoft Azure, including a resource group and a mssql database.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:


```hcl
module "mssql-server" {
  depends_on = [module.subnet]
  source     = "git::https://github.com/cypik/terraform-azure-mssql-db.git?ref=v1.0.0"

  sqlserver_name = "testmssql1"
  database_name  = "demomssqldb"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  virtual_network_id  = join("", module.vnet[*].id)
  subnet_id           = module.subnet.default_subnet_id

  admin_username = "sqladmin"
  admin_password = "ghgjFThgHnn124"

  sql_database_edition         = "Standard"
  sqldb_service_objective_name = "S1"
  sql_server_version           = "12.0"
}

```
This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs
The following input variables can be configured:

- 'name': The name of the Microsoft SQL Server.
- 'environment': The environment or purpose of the resources.
- 'location':  Specifies the supported Azure location where the resource exists.
- 'resource_group_name': The name of the resource group in which to create the Microsoft SQL Server.
- 'virtual_network_id':  The ID of the Virtual Network that should be linked to the DNS Zone.
- 'subnet_id': TThe ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint.
- 'admin_username': The administrator login name for the new server.
- 'admin_password': The password associated with the administrator_login user.
- 'sql_database_edition': The edition of the database to be created.
- 'sqldb_service_objective_name': The service objective name for the database.
- 'sql_server_version': The version for the new server.

## Module Outputs
This module provides the following outputs:

- 'primary_sql_server_id': The Microsoft SQL Server ID.
- 'primary_sql_server_fqdn': The fully qualified domain name of the Azure SQL Server.
- 'sql_database_id': The SQL Database ID.
# Examples
For detailed examples on how to use this module, please refer to the '[example](https://github.com/cypik/terraform-azure-mssql-db/blob/master/example)' directory within this repository.

# License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/cypik/terraform-azure-mssql-db/blob/master/LICENSE) file for more details.

# Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.