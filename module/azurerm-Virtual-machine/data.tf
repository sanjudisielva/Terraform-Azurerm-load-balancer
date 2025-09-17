data "azurerm_network_interface" "data_nic" {
  name                = var.nic_name
  resource_group_name = var.resource_group_name
}