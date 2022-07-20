output "instance_ip" {
  value = aws_instance.jhub.public_ip
}

output "instance_arn" {
  value = aws_instance.jhub.arn
}
