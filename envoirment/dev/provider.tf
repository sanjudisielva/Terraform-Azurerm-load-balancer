terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "privateloadbalancerRG"
    storage_account_name = "loadbalancerstorage1"
    container_name       = "lbcontainer"
    key                  = "lbtf.state"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "13dfd1e6-6770-4299-b7ea-6aa09b346468"
}