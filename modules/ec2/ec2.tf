# Variables
variable "image" {}
variable "instance_type" {}
variable "key_pair" {}
variable "subnetID" {
  type = string
}

# EC2 Instance
resource "aws_instance" "nginx_server" {
  ami           = var.image
  instance_type = var.instance_type
  key_name = var.key_pair
  subnet_id = var.subnetID

tags = {
    Name = "tf-test"
  }

}

output "instanceID" {
  value = aws_instance.nginx_server.id
}