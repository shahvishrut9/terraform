output "vm_info" {
  value = {
    hostname = azurerm_windows_virtual_machine.windows_vm[*].computer_name       
    win_private_ip = azurerm_network_interface.windows_nic[*].private_ip_address
    win_public_ip = azurerm_public_ip.windows_pip[*].ip_address
    win_vm_fqdn = azurerm_public_ip.windows_pip[*].fqdn
    windows_vm_id  = azurerm_windows_virtual_machine.windows_vm[*].id
  }
}
