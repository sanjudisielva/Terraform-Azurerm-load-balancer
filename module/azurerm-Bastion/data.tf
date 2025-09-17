data "azurerm_subnet" "data_subnet"{
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}
data "azurerm_public_ip" "data_bastion_pip" {
  name                = var.bastion-pip
  resource_group_name = var.resource_group_name
}