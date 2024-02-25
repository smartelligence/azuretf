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
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.

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
  target_network_interface = module.network.target_network_interface
}

output "resource_group_name" {
  value = azurerm_resource_group.examplerg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.examplerg.location
}
