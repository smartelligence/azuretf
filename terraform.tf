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

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# include network tf file
module "network" {
  source = "./network"
}

# include vm tf file
module "vm" {
  source = "./servers"
}

