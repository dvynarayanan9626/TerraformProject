output "Public_ip_address" {
  value = aws_instance.instance.public_ip
}
output "Instance_id" {
  value = aws_instance.instance.id  
}
