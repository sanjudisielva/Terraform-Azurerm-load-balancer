resource "azurerm_bastion_host" "bastion-host" {
  name                = var.bastion_host_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


   ip_configuration {
    name                          = var.ip_configuration_bastion_name
    subnet_id                     = data.azurerm_subnet.data_subnet.id
    public_ip_address_id          = data.azurerm_public_ip.data_bastion_pip.id
    
  }
}

data "azurerm_subnet" "data_subnet