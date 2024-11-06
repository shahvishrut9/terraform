terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01580095RG"
    storage_account_name = "tfstaten01580095sa"
    container_name       = "tfstatefiles"
    key                  = "tfstate"

  }

}
