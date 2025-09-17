data "azurerm_network_interface" "data_nic" {
  name                = var.nic_name
  resource_group_name = var.resource_group_name
}

data "azurerm_lb" "loadbalancer" {
  name                = var.loadbalancer_name
  resource_group_name = var.resource_group_name
}

data "azurerm_lb_backend_address_pool" "backendpool" {
  name            = var.backend_address_pool_name
  loadbalancer_id = data.azurerm_lb.loadbalancer.id
}