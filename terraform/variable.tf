variable "instance_type" {
  default = "t2.micro"
}

variable "ami_us_east" {
  default = "ami-0c2b8ca1dad447f8a" # Ubuntu 20.04 for us-east-1
}

variable "ami_us_west" {
  default = "ami-0d1cd67c26f5fca19" # Ubuntu 20.04 for us-west-2
}
