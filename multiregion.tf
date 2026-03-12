provider "aws" {
  alias = "A"
  region = "us-east-1"
}
provider "aws" {
  alias = "B"
  region = "us-east-2"  
}
resource "aws_instance" "instance1" {
   ami = "ami-02dfbd4ff395f2a1b"
   instance_type = "t3.micro"
   provider = aws.A
}
resource "aws_instance" "instance2" {
   ami = "ami-0b0b78dcacbab728f"
   instance_type = "t3.micro"
   provider = aws.B
  
}

