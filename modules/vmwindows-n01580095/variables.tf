locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "vishrut.shah"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "availability_set_name" {
  type        = string
}

variable "vm_count" {
  type        = number
}

variable "vm_size" {
  type        = string
}

variable "admin_username" {
  type        = string
}

variable "admin_password" {
  type        = string
}

variable "subnet_id" {
  type        = string
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
}

variable "vm_name" {
  type        = string
}

variable "os_info" {
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "os_disk" {
  default = {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
