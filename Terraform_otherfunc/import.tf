provider "aws" {
    region = "us-east-2" 
}
resource "aws_instance" "example" {
    ami ="ami-0b0b78dcacbab728f"
    instance_type = "t3.micro"
    tags = {
      Name = "myserver-01"
    }
}

