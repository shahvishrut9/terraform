output "resource_group_name" {
  value = module.rgroup-n01580095.rg_name
}

output "vnet_name" {
  value = module.network-n01580095.vnet_name
}

output "vnet_address_space" {
  value = module.network-n01580095.vnet_address_space
}

output "subnet_name" {
  value = module.network-n01580095.subnet_name
}

output "subnet_address_prefix" {
  value = module.network-n01580095.subnet_address_prefix
}

output "nsg_name" {
  value = module.network-n01580095.nsg_name
}

output "log_analytics_workspace_name" {
  value = module.common-n01580095.log_analytics_workspace_name
}

output "recovery_services_vault_name" {
  value = module.common-n01580095.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common-n01580095.storage_account_name
}

output "linux_vm_info" {
  value = {
    hostname         = module.vmlinux-n01580095.vm_info.hostname
    linux_vm_fqdn    = module.vmlinux-n01580095.vm_info.linux_vm_fqdn
    linux_private_ip = module.vmlinux-n01580095.vm_info.linux_private_ip
    linux_public_ip  = module.vmlinux-n01580095.vm_info.linux_public_ip
  }
}

output "windows_vm_info" {
  value = {
    hostname           = module.vmwindows-n01580095.vm_info.hostname
    windows_vm_fqdn    = module.vmwindows-n01580095.vm_info.win_vm_fqdn
    windows_private_ip = module.vmwindows-n01580095.vm_info.win_private_ip
    windows_public_ip  = module.vmwindows-n01580095.vm_info.win_public_ip
  }
}

output "datadisk_names" {
  value = module.datadisk-n01580095.datadisk_names
}

output "load_balancer_name" {
  value = module.loadbalancer-n01580095.load_balancer_name
}

output "postgresql_server_name" {
  value = module.database-n01580095.postgresql_server_name
}
