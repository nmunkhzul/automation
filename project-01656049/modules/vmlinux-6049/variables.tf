variable "avs_linux" {
}
variable "rg" {
}
variable "location" {
}
variable "storage_account" {
}
variable "vmlinux_name" {
  type = map(string)
}
variable "linux_size" {
}
variable "subnet_id" {
}
variable "admin_username" {
}
variable "netwatcher_extension" {
  type = map(string)
}
variable "monitor_extension" {
  type = map(string)
}

variable "common_tags" {}
