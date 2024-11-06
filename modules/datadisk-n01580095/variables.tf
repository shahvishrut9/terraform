locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "vishrut.shah"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

variable "disk_count" {
  type        = number
}

variable "vm_name" {
  type = list(string)
}

variable "linux_vm_ids" {
  type  = list(string)
}

variable "windows_vm_ids" {
  type = list(string)
}

variable "location" {
  type        = string
}

variable "rg_name" {
 type        = string
}
