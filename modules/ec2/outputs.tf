output "instance_id" {
  value = aws_instance.nodejs.id
}

output "public_ip" {
  value = aws_instance.nodejs.public_ip
}

output "public_dns" {
  value = aws_instance.nodejs.public_dns
}
