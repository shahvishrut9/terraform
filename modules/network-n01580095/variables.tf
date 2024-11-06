variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefix" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name = "vishrut.shah"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
