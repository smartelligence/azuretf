variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

variable "network_interface_id" {
  description = "The id of the network interface"
  type        = string
}

resource "azurerm_linux_virtual_machine" "examplevm" {
  name                = "example-vm"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = "Standard_A1"
  admin_username      = "adminuser"
  network_interface_ids = [
    network_interface_id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("ssh/azureadminvm.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}