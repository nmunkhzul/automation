output "hostnames" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].name
}
output "fqdn" {
  value = values(azurerm_public_ip.linux_pip)[*].fqdn
}
output "private_ip" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].private_ip_address
}
output "public_ip" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].public_ip_address
}
output "vmlinux_ids" {
  description = "Map of VM names to their IDs"
  value       = { for vm in azurerm_linux_virtual_machine.vmlinux : vm.name => vm.id }
}
output "vmlinux_nics" {
  description = "Map of NIC ip_configurarion name to nic id"
  value       = { for nic in azurerm_network_interface.linux_nic : nic.ip_configuration[0].name => nic.id }
}
output "vmnames" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.fqdn]
}
