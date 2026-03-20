provider "aws" {
    region = "us-east-2" 
}

# s3 bucket is creation:

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "divya-terraform-state-file-180326"
}
# ec2 instance:

resource "aws_instance" "Linux" {
  ami           = "ami-0b0b78dcacbab728f"
  instance_type = "t3.micro"

# depends_on is used to s3 bucket will be created firse then ec2 instance will created

depends_on = [aws_s3_bucket.s3_bucket]
  tags = {
    Name = "My_Instance"
  }

}
