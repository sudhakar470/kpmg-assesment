
variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
variable "public_subnet1_cidr" {}
variable "public_subnet2_cidr" {}
variable "private_subnet1_cidr" {}
variable "private_subnet2_cidr" {}
variable "public_subnet1_name" {}
variable "public_subnet2_name" {}
variable "private_subnet1_name" {}
variable "private_subnet2_name" {}
variable public_routing_table {}
variable "private_routing_table" {}
variable "environment" { default = "dev" }
variable "db_name" {}
variable "db_allocated_storage" {}
variable "app_environment" {}
variable "db_instance_class" {}
variable "db_username" {}
variable "db_backup_retention_period" {}
variable "db_multi_az" {}
variable "db_password" {}

locals {
  private_sg_dev = sg-00f5383b2bd1dce11
  tags = {
    App             = "test"
    Environment     = "${var.environment}"
    Owner           = "sudhakar"
  }
}