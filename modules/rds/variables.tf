variable "name" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "allocated_storage" {}
variable "db_name" {}
variable "username" {}
variable "password" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "publicly_accessible" {
  type    = bool
  default = false
}
variable "tags" {
  type = map(string)
  default = {}
}
