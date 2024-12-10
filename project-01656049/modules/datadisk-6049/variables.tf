variable "rg" {}
variable "location" {}
variable "data_disk_attr" {
  type = map(string)
}
variable "vms" {
  type = map(string)
}
variable "data_disk_caching" {}
variable "common_tags" {}
