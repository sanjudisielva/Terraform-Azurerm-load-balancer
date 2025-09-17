module "rg" {
  source                  = "../../module/azurerm-resource-group"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
}

module "vnet" {
  depends_on              = [module.rg]
  source                  = "../../module/azurerm-V-net"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  virtual_network_name    = "LBVnet"
  address_space           = ["10.0.0.0/16"]
}

module "subnet1" {
  depends_on              = [module.vnet]
  source                  = "../../module/azurerm-subnet"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  subnet_name             = "LBsubnet"
  address_prefixes        = ["10.0.1.0/24"]
  virtual_network_name    = "LBVnet"
}
module "subnet2" {
  depends_on              = [module.vnet]
  source                  = "../../module/azurerm-subnet"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  subnet_name             = "AzureBastionSubnet"
  address_prefixes        = ["10.0.2.0/26"]
  virtual_network_name    = "LBVnet"
}
module "publicip" {
  source                  = "../../module/azurerm-public-ip"
  depends_on              = [module.rg]
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  publicip_name           = "Lpublic_ip"
}

module "bastion-pip" {
  source                  = "../../module/azurerm-public-ip-Bastion"
  depends_on              = [module.rg]
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  bastion-pip             = "LB-bastion-pip"
}


module "nic1" {
  source                  = "../../module/azurerm-NIC"
  depends_on              = [module.rg, module.subnet1, module.vnet]
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  subnet_name             = "LBsubnet"
  virtual_network_name    = "LBVnet"
  nic_name                = "LBnic1"
  ip_configuration_name   = "lb-fr-confi-1"

}
module "nic2" {
  source                  = "../../module/azurerm-NIC"
  depends_on              = [module.rg, module.subnet1, module.vnet]
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  subnet_name             = "LBsubnet"
  virtual_network_name    = "LBVnet"
  nic_name                = "LBnic2"
  ip_configuration_name   = "lb-fr-confi-2"

}
module "lb" {
  source                         = "../../module/azurerm-load-balancer"
  depends_on                     = [module.rg, module.publicip]
  resource_group_name            = "privateloadbalancerRG1"
  resource_group_location        = "east us"
  backend_pool_name              = "lb-backend-pool"
  frontend_ip_configuration_name = "lb-fr-confi"
  azurerm_lb_rule_name           = "lb_rule"
  loadbalancer_name              = "privateload_balancer"
  lb-probe-name                  = "lb_probe"
  publicip_name                  = "Lpublic_ip"
}

module "bastion" {
  depends_on                    = [module.rg, module.subnet2, module.vnet, module.bastion-pip]
  source                        = "../../module/azurerm-bastion"
  bastion_host_name             = "lb_bastion"
  resource_group_name           = "privateloadbalancerRG1"
  resource_group_location       = "east us"
  subnet_name                   = "AzureBastionSubnet"
  virtual_network_name          = "LBVnet"
  ip_configuration_bastion_name = "ip-config_bastion"
  bastion-pip                   = "LB-bastion-pip"
}

module "bacend_config1" {
  depends_on                                   = [module.rg, module.nic1, module.lb]
  source                                       = "../../module/azurerm-backend-configuration"
  azurerm_lb_backend_address_pool_address_name = "vm-1-adding"
  backend_address_pool_name                    = "lb-backend-pool"
  resource_group_name                          = "privateloadbalancerRG1"
  loadbalancer_name                            = "privateload_balancer"
  nic_name                                     = "LBnic1"
  frontend_ip_configuration_name               = "lb-fr-confi-1"
}
module "backend_config2" {
  depends_on                                   = [module.rg, module.nic2, module.lb]
  source                                       = "../../module/azurerm-backend-configuration"
  azurerm_lb_backend_address_pool_address_name = "vm-1-adding"
  backend_address_pool_name                    = "lb-backend-pool"
  resource_group_name                          = "privateloadbalancerRG1"
  loadbalancer_name                            = "privateload_balancer"
  nic_name                                     = "LBnic2"
  frontend_ip_configuration_name               = "lb-fr-confi-2"
}
module "vm1" {
  depends_on              = [module.rg, module.vnet, module.subnet1, module.nic1]
  source                  = "../../module/azurerm-Virtual-machine"
  nic_name                = "LBnic1"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  vm_name                 = "forntend-vm1"
}
module "vm2" {
  source                  = "../../module/azurerm-Virtual-machine"
  depends_on              = [module.rg, module.vnet, module.subnet1, module.nic2]
  nic_name                = "LBnic2"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  vm_name                 = "forntend-vm2"
}

module "nsg_attech_nic1" {
  depends_on              = [module.rg , module.nic1]
  source                  = "../../module/azurerm-NSG"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  nic_name                = "LBnic1"
  nsg_name                = "mynsg"
}

module "nsg_attech_nic2" {
  depends_on              = [module.rg , module.nic2]
  source                  = "../../module/azurerm-NSG"
  resource_group_name     = "privateloadbalancerRG1"
  resource_group_location = "east us"
  nic_name                = "LBnic2"
  nsg_name                = "mynsg"
}
