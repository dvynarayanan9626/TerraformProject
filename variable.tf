variable "ami" {
  description = "AMI of the instance"
  type = string 
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  description = "Key_pair of the instance"
  type = string
}
