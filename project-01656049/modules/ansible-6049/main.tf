resource "local_file" "inventory" {
  filename = "../ansible/hosts.ini"
  content  = <<EOT
  [linux]
  %{for fqdn in var.fqdns}
    ${fqdn.key}
  %{endfor}
  EOT
}
