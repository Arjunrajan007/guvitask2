output "us_east_public_ip" {
  value = aws_instance.us_east_instance.public_ip
}

output "us_west_public_ip" {
  value = aws_instance.us_west_instance.public_ip
}
