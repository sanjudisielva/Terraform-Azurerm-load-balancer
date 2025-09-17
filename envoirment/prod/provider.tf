terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.42.0"
    }
  }
  backend "azurerm" {
    
    
  }
}

provider "azurerm" {
  features {}
  subscription_id = ""
}