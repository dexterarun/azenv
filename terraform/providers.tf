terraform {
  backend "azurerm" {

  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.57.0"
    }
  }
}

provider "azurerm" {
  features {}
}