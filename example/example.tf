provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "cypik/resource-group/azure"
  version     = "1.0.1"
  name        = "app-test"
  environment = "test"
  location    = "North Europe"
}

module "vnet" {
  source              = "cypik/vnet/azure"
  version             = "1.0.1"
  name                = "app22"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.0.0.0/16"
}

module "subnet" {
  source               = "cypik/subnet/azure"
  version              = "1.0.1"
  name                 = "app11"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet[*].name)

  #subnet
  subnet_names    = ["subnet1"]
  subnet_prefixes = ["10.0.0.0/20"]

  # route_table
  enable_route_table = true
  route_table_name   = "default_subnet"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}

module "mssql-server" {
  depends_on = [module.subnet]
  source     = "./../"

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
