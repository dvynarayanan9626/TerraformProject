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
provider "aws" {
  region = "us-east-1"  
}
resource "aws_launch_template" "Template" {
  instance_type = var.instance_type
  image_id = var.ami
  key_name = var.key_name  
}
resource "aws_autoscaling_group" "Auto" {
           availability_zones = ["us-east-1a"]
           max_size = 1
           min_size = 1
           desired_capacity = 1
        launch_template {
          id = aws_launch_template.Template.id
          version = "$Latest"
        }
}
output "public_ip" {
  value = aws_autoscaling_group.Auto.name
}
output "Instance_id" {
  value = aws_autoscaling_group.Auto.id 
}
