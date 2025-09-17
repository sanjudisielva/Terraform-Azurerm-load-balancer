resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion-pip
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}