terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"  # You can specify the version as per your requirements
    }
  }
}

provider "azurerm" {
  features {}  # The features block is required, but can be empty
  # Other optional configurations like authentication can be added here
}

resource "azurerm_resource_group" "examplerg" {
  name     = "example-resources"
  location = "East US"
}

# include network tf file
module "network" {
  source = "./network"
  resource_group_name    = azurerm_resource_group.examplerg.name
  resource_group_location = azurerm_resource_group.examplerg.location
}

# include vm tf file
module "vm" {
  source = "./servers"
  resource_group_name    = azurerm_resource_group.examplerg.name
  resource_group_location = azurerm_resource_group.examplerg.location
  network_interface_id = module.network.network_interface_id
}

output "resource_group_name" {
  value = azurerm_resource_group.examplerg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.examplerg.location
}
