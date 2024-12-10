
output "resource_group_name" {
  value = module.rgroup.rg_name.name
}
output "vnet_name" {
  value = module.network.vnet_name
}
output "subnet_name" {
  value = module.network.subnet.name
}
output "linux_hostnames" {
  value = module.linux.hostnames
}
output "linux_fqdn" {
  value = module.linux.fqdn
}
output "linux_private_ip" {
  value = module.linux.private_ip
}
output "linux_public_ip" {
  value = module.linux.public_ip
}

output "loadbalancer_name" {
  value = module.loadbalancer.loadbalancer_name
}

output "postgre_name" {
  value = module.database.postgre_instance_name
}
