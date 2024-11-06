resource "azurerm_availability_set" "n01580095-avset" {
  name                = var.availability_set_name
  location            = var.location
  resource_group_name = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed = true
}

resource "azurerm_public_ip" "n01580095-pip" {
  for_each            = var.vm_name
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  domain_name_label   = each.key
}

resource "azurerm_network_interface" "n01580095-nic" {
  for_each            = var.vm_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.n01580095-pip[each.key].id    
  }
}

resource "azurerm_linux_virtual_machine" "n01580095-vm" {
  for_each            = var.vm_name
  name                = "${each.key}"
  location            = var.location
  resource_group_name = var.rg_name
  availability_set_id = azurerm_availability_set.n01580095-avset.id
  network_interface_ids = [
    azurerm_network_interface.n01580095-nic[each.key].id,
  ]
  size             = "Standard_DS1_v2"
  computer_name         = "linux-${each.key}"
  admin_username        = var.admin_username
  
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  os_disk {
    name              = "${each.key}-osdisk"
    caching           = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.os_info.publisher
    offer     = var.os_info.offer
    sku       = var.os_info.sku
    version   = var.os_info.version
  }
  
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }
 tags = local.common_tags
}

resource "azurerm_virtual_machine_extension" "AzureMonitorLinuxAgent" {
  for_each             = var.vm_name
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.n01580095-vm[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.7"
  tags = local.common_tags
}

resource "azurerm_virtual_machine_extension" "NetworkWatcherAgentLinux" {        
  for_each             = var.vm_name
  name                 = "NetworkWatcherAgentLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.n01580095-vm[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
  tags = local.common_tags
}
