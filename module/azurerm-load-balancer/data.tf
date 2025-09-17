data "azurerm_public_ip" "data_pip" {
  name                = var.publicip_name
  resource_group_name = var.resource_group_name
}