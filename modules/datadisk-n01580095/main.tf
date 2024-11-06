resource "azurerm_managed_disk" "datadisks" {
  count                = var.disk_count
  name                 = "${element(var.vm_name, count.index)}-datadisk-${format("%1d", count.index + 1)}"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_datadisk_attach" {
  count              = length(var.linux_vm_ids)
  managed_disk_id    = element(azurerm_managed_disk.datadisks[*].id, count.index)
  virtual_machine_id = element(var.linux_vm_ids, count.index)
  lun                = count.index
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_data_disk_attachment" "windows_datadisk_attach" {
  count              = length(var.windows_vm_ids)
  managed_disk_id    = azurerm_managed_disk.datadisks[count.index + 3].id
  virtual_machine_id = element(var.windows_vm_ids, count.index)
  lun                = count.index
  caching            = "ReadWrite"
}
