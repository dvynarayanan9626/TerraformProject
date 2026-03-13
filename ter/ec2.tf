terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Create Vpc 
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
      Name = "my_vpc"
    }
}
#creating public subnet
resource "aws_subnet" "publicsubnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "public_subnet"
    }
}
#creating internet gateway
resource "aws_internet_gateway" "myIgw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name ="myIgw"
    }
}
# creating route table 
resource "aws_route_table" "myrt" {
    vpc_id = aws_vpc.my_vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
}
# Associating subnet with route table
resource "aws_route_table_association" "subnetAsso" {
    subnet_id = aws_subnet.publicsubnet.id
    route_table_id = aws_route_table.myrt.id 
}
# creating Ec2 instance
resource "aws_instance" "myinstance" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.micro"
    key_name = "Ubuntu -01"
    subnet_id = aws_subnet.publicsubnet.id
    associate_public_ip_address = true
    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              touch /home/ec2-user/file1 
              EOF
}



