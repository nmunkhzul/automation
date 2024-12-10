variable "rg" {
}
variable "location" {
}
variable "lb" {
  type = map(string)
}
variable "lb_pip" {
  type = map(string)
}
variable "vmlinux_nics" {
  type = map(string)
}
variable "service_port" {}
variable "common_tags" {}
