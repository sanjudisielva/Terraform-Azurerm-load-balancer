resource "azurerm_network_interface_backend_address_pool_association" "vm_association" {
  network_interface_id    = data.azurerm_network_interface.data_nic.id
  ip_configuration_name   =var.frontend_ip_configuration_name
  backend_address_pool_id =data.azurerm_lb_backend_address_pool.backendpool.id
}