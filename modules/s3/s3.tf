provider "aws" {
  region = "us-west-2"
  profile = "shruti"
}
resource "aws_s3_bucket" "bucket" {
  bucket = "testterraforshruti3"
}