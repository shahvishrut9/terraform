variable "law_name" {
  type        = string
}

variable "log_sku" {
  type        = string
}

variable "retention" {
  type        = string
}

variable "location" {
  type        = string
}

variable "rg_name" {
  type        = string
}

variable "rsv_name" {
  type        = string
}

variable "vault_sku" {
  type        = string
}

variable "sa_name" {
  type        = string
}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "vishrut.shah"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
