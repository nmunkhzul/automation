terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateRG"
    storage_account_name = "tfstate01656049sa"
    container_name       = "tfstatefiles"
    key                  = "tfstate_n01656049"
  }
}
