terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<=3.64.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "storage-account" {
  source                   = "avinor/storage-account/azurerm"
  version                  = "3.5.2"
  location                 = var.location
  name                     = var.name
  resource_group_name      = var.resource_group_name
  access_tier              = var.access_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  containers               = var.containers
  resource_group_create    = var.resource_group_create
  soft_delete_retention    = var.soft_delete_retention
  tags                     = var.tags
}