# Variables
variable "vpcID" {}
variable "pub-sub-az" {
  type = list
}
variable "pub-sub-cidr" {}
variable "pub-ip" {
  default = "true"
}


variable "public_subnet_cidr" {
  type    = list(any)
  # type = "list"
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpcID
  tags = {
    Name = "TF-igw"
  }
}

# Routing Table
resource "aws_route_table" "public-rt" {
  vpc_id = var.vpcID
  route {
    cidr_block = "0.0.0.0/0"                   
    gateway_id = aws_internet_gateway.gw.id
  }
tags = {
    Name = "pub-rt"
  }
}

# Subnet
resource "aws_subnet" "pub-sub" {
  # count = "${length(var.public_subnet_cidr)}"
  count = 2
  vpc_id                  = var.vpcID
  cidr_block              = "${var.public_subnet_cidr[count.index]}"
  # cidr_block = "${element(var.public_subnet_cidr,count.index)}"
  map_public_ip_on_launch = var.pub-ip
  availability_zone       = "${var.pub-sub-az[count.index]}"
  # availability_zone       = var.pub-sub-az

}




# Route Table Association
# 


output "mySubnet1" {
  value = aws_subnet.pub-sub[0].id
}

output "mySubnet2" {
  value = aws_subnet.pub-sub[1].id
}
