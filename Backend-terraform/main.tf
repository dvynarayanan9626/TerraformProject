provider "aws" {
    region = "us-east-1"  
}

variable "ami" {
    description = "this is defining the AMI of the instance"
    type = string
    default = "ami-02dfbd4ff395f2a1b"  
}
variable "instance_type" {
    description = "this is defininh the instance type of the instance"
    type = string
    default = "t3.micro"  
}
resource "aws_instance" "instance" {
    ami = var.ami
    instance_type = var.instance_type
    associate_public_ip_address = true  
}
resource "aws_s3_bucket" "s3_bucket" {
    bucket = "divya-terraform-state-file-180326"
}

