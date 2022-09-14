provider "aws" {
  region = var.region
  # access_key = "AKIA3BPZNRG7FV4GRNBD"
  # secret_key = "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" 
  profile = "shruti"

}

# EC2
module "ec2" {
  source = "./modules/ec2"
  instance_type = "t2.small"
  image = "ami-07d59d159373b8030"
  key_pair = "new-TF"
  subnetID = module.subnet.mySubnet1
 }

# VPC
module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

# Public Subnet
module "subnet" {
   source = "./modules/pubsub"
   vpcID = module.vpc.myvpc
   pub-sub-az = ["us-west-2a", "us-west-2b"]
   pub-sub-cidr = var.public_subnet_cidr[0]
}

# ELB
module "elb" {
   source = "./modules/ELB"
   vpcID = module.vpc.myvpc
   tg-instances = module.ec2.instanceID
   lb_subnets = [ module.subnet.mySubnet1, module.subnet.mySubnet2 ]
}

#terraform Statelock 

terraform {
  backend "s3" {
    bucket = "testterraforshruti3"
    key = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-lock"
    profile = "shruti"
    
  }
}
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
