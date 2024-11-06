locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "vishrut.shah"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

variable "availability_set_name" {
  type = string
}

variable "location" {
 type = string
}

variable "rg_name" {
  type = string
}

variable "vm_name" { 
  type        = map(string)
}

variable "admin_username" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "boot_diagnostics_storage_account_uri" {
  description = "URI of the storage account used for boot diagnostics"
  type        = string
}

variable "public_key" {
  default     = "/home/n01580095/.ssh/id_rsa.pub"
}

variable "priv_key" {
  default     = "/home/n01580095/.ssh/id_rsa"
}

variable "os_info" {
  default = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}

variable "os_disk" {
  default = {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
