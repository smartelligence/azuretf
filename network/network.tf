variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

resource "azurerm_virtual_network" "examplevn" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "examplesubnet" {
  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.examplevn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "exampleif" {
  name                = "example-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.examplesubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

output "network_interface_id" {
  value = azurerm_network_interface.exampleif.id
}
