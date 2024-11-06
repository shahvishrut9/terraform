variable "location" {
 type = string
}

variable "rg_name" {
 type = string
}

variable "loadbalancer_name" {
  type        = string
}

variable "vm_name" {
  type        = list(string)
}

variable "network_interface_ids" {
  type        = list(string)
}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "vishrut.shah"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
