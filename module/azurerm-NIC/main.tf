resource "azurerm_network_interface" "nic"{
  name                =var.nic_name
  location            =var.resource_group_location
  resource_group_name = var.resource_group_name
  

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = data.azurerm_subnet.data_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
