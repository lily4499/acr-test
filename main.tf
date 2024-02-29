# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

variable "resource_group_location" {
  type        = string
  default     = "eastus"                 #your location
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "lili-rg"                            #your resource group name
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription"
}


# Create a resource group
resource "azurerm_resource_group" "arg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Create Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "liliacr"                             #your acr name
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  sku                 = "Standard"
  admin_enabled       = false
}

# Output Registry Name
output "registry_name" {
  value = azurerm_container_registry.acr.name
}

# Output Login Server
output "login_server" {
  value = azurerm_container_registry.acr.login_server
}

