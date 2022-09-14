# Variables
variable "vpcID" {
  default = "vpc-0b9a29aae72bdebed"
}

variable "tg-instances" {}
variable "lb_subnets" {
  type = list(string)
}


resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.lb_subnets

  tags = {
    Environment = "testing"
  }
}

# ALB Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

# Target-Group
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcID
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = var.tg-instances
  port             = 80
}

