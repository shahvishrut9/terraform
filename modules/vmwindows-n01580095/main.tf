resource "azurerm_availability_set" "windows_avset" {
  name                = var.availability_set_name
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed             = true
  tags                = local.common_tags
}

resource "azurerm_public_ip" "windows_pip" {
  count               = var.vm_count
  name                = "${var.vm_name}-pip-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "${var.vm_name}${format("%1d", count.index + 1)}"
  tags                = local.common_tags
}

resource "azurerm_network_interface" "windows_nic" {
  count               = var.vm_count
  name                = "${var.vm_name}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.vm_name}-nic-config-${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.windows_pip[*].id, count.index)
  }
  tags                = local.common_tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.vm_count
  name                = "win-${var.vm_name}-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  availability_set_id = azurerm_availability_set.windows_avset.id
  network_interface_ids = [
    element(azurerm_network_interface.windows_nic[*].id, count.index),
  ]
  size                = var.vm_size

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.os_info.publisher
    offer     = var.os_info.offer
    sku       = var.os_info.sku
    version   = var.os_info.version
  }
  admin_username = var.admin_username
  admin_password = var.admin_password

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }
  tags                = local.common_tags
}

resource "azurerm_virtual_machine_extension" "Antimalware" {
  count               = var.vm_count
  name                = "IaaSAntimalware"
  virtual_machine_id  = element(azurerm_windows_virtual_machine.windows_vm[*].id, count.index)
  publisher           = "Microsoft.Azure.Security"
  type                = "IaaSAntimalware"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "Exclusions": {
            "Extensions": ".log;.ldf",
            "Paths": "D:\\IISlogs;D:\\CustomFolder",
            "Processes": "mssence.svc"
        },
        "RealtimeProtectionEnabled": true,
        "ScheduledScanSettings": {
            "isEnabled": true,
            "scanType": "Quick",
            "day": "7",
            "time": "120"
        }
    }
  SETTINGS
  tags                = local.common_tags
}
