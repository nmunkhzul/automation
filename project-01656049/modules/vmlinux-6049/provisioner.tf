resource "null_resource" "linux_provisioner" {
  for_each   = var.vmlinux_name
  depends_on = [azurerm_linux_virtual_machine.vmlinux]

  provisioner "remote-exec" {
    inline = [
      "hostnamectl | grep 'hostname'"
    ]
    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file("/home/${var.admin_username}/.ssh/id_rsa")
      host        = azurerm_public_ip.linux_pip[each.key].fqdn
    }
  }
}
