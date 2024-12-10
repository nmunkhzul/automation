resource "azurerm_managed_disk" "datadisk" {
  for_each             = var.vms
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.rg
  storage_account_type = var.data_disk_attr["data_disk_type"]
  create_option        = var.data_disk_attr["data_disk_create_option"]
  disk_size_gb         = var.data_disk_attr["data_disk_size"]
  tags                 = var.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
  for_each           = var.vms
  virtual_machine_id = var.vms[each.key]
  managed_disk_id    = azurerm_managed_disk.datadisk[each.key].id
  lun                = "0"
  caching            = var.data_disk_caching
}
