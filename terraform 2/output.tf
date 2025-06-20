output "us_east_public_ip" {
  value = aws_instance.web_us_east.public_ip
}

output "us_west_public_ip" {
  value = aws_instance.web_us_west.public_ip
}
