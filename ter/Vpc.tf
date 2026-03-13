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

# Create VPC
resource "aws_vpc" "MyVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my_Vpc"
  }
}

# create subnet
resource "aws_subnet" "MySub" {
  vpc_id     = aws_vpc.MyVpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PublicSub"
  }
}
# create IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.MyVpc.id

  tags = {
    Name = "My_Igw"
  }
}
# create route table
resource "aws_route_table" "Route" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

   tags = {
    Name = "My_Route"
  }
}

# subnet association with route table
resource "aws_route_table_association" "Asso" {
  subnet_id      = aws_subnet.MySub.id
  route_table_id = aws_route_table.Route.id
}
