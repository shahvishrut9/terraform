output "vm_info" {
  value = {
    hostname          = values(azurerm_linux_virtual_machine.n01580095-vm)[*].name      
    linux_vm_fqdn     = values(azurerm_public_ip.n01580095-pip)[*].fqdn
    linux_private_ip  = values(azurerm_network_interface.n01580095-nic)[*].private_ip_address
    linux_vm_ids = values(azurerm_linux_virtual_machine.n01580095-vm)[*].id
    linux_network_ids = values(azurerm_network_interface.n01580095-nic)[*].id     
    linux_public_ip   = values(azurerm_public_ip.n01580095-pip)[*].ip_address     
  }
}
