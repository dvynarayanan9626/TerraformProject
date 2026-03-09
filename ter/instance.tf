resource "aws_instance" "Linux" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"
  key_name = "Ubuntu -01"

  tags = {
    Name = "My_Instance"
  }
}
