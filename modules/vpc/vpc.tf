# Variables
variable "cidr_block" {}

# VPC
resource "aws_vpc" "custom-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
}

# Output Variable
output "myvpc" {
  value = aws_vpc.custom-vpc.id
}