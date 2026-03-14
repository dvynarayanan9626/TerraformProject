
# creating variable for ec2 instance
variable "instance_type" {
  description = "Instance type"
  type = string
  default =  "t3.micro" 
}
variable "ami" {
  description = "AMI"
  type = string
  default = "ami-02dfbd4ff395f2a1b"  
}
variable "key_name" {
  description = "Key_pair"
  type = string
  default = "Ubuntu -01"  
}
# Creating provider
provider "aws" {
  region = "us-east-1"  
}
# creating vpc resource
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
      name = "Myvpc"
    }
}
#creating internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      name = "igw"
      }  
}
#creating security group resource
resource "aws_security_group" "security" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      name = "Mysecuritygroup"
    }  
}
# creating inbound and outbound traffic of the sercurity group
resource "aws_vpc_security_group_ingress_rule" "Inbound" {
   security_group_id = aws_security_group.security.id
   cidr_ipv4 = "0.0.0.0/0"
   from_port         = 80
   ip_protocol       = "tcp"
   to_port           = 80  
}
#outbound
resource "aws_vpc_security_group_egress_rule" "Outbound" {
  security_group_id = aws_security_group.security.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol       = "-1"
}
# creating subnets
resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      name = "Publicsubnet"
    }
}
resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags ={
        name ="Publicsubnet" 
    }  
}
#creating launch template for auto scaling
resource "aws_launch_template" "Template" {
  instance_type = var.instance_type
  image_id = var.ami
  key_name = var.key_name  
}
# Creating auto scaling
resource "aws_autoscaling_group" "Auto" {
           max_size = 2
           min_size = 1
           desired_capacity = 2   
           vpc_zone_identifier = [
               aws_subnet.public1.id,
               aws_subnet.public2.id
               ]  
        target_group_arns = [aws_lb_target_group.Target.arn] # target group of LB

        launch_template {
          id = aws_launch_template.Template.id
          version = "$Latest"
        }
}

# creating target group for load balancer
resource "aws_lb_target_group" "Target" {
  name = "Loadbalancertargetgroup"
  port = 80
  target_type = "instance"
  protocol = "HTTP"  
  vpc_id = aws_vpc.vpc.id
}
# creating load balancer
resource "aws_lb" "LB" {
  name = "Loadbalancer"
  internal = false
  load_balancer_type = "application"
  enable_deletion_protection = false
  security_groups = [aws_security_group.security.id]

  subnets = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}
# Creating load balancer listener to send traffics to auto scaling instances
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.LB.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.Target.arn
  }
  
}
# creating output to get auto scaling id and load balancer arn
output "aws_autoscaling_name" {
  value = aws_autoscaling_group.Auto.name
}
output "load_balancer_arn" {
  value = aws_lb.LB.arn
}
