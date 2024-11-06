output "datadisk_names" {
  value = [for i in range(4) : azurerm_managed_disk.datadisks[i].name]
}
