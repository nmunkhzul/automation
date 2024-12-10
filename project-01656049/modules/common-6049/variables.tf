variable "rg" {}
variable "location" {}
variable "common_tags" {}
variable "log_analytics_workspace" {
  type = map(string)
}
variable "recovery_services_vault" {
  type = map(string)
}
variable "storage_account" {
  type = map(string)
}
