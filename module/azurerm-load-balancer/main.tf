resource "azurerm_lb" "MyLoadbalancer" {
  name                = var.loadbalancer_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.data_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lbbackend"{
  loadbalancer_id = azurerm_lb.MyLoadbalancer.id
  name            = var.backend_pool_name
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.MyLoadbalancer.id
  name                           = var.azurerm_lb_rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name =  var.frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lbbackend.id]
  probe_id                       = azurerm_lb_probe.probe.id
}
resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.MyLoadbalancer.id
  name            = var.lb-probe-name
  port            = 80
}