variable "region" {
    default = "us-west-2"
}


variable "public_subnet_cidr" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}
