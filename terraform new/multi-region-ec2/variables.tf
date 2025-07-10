variable "ami_id_us_east" {
  description = "AMI ID for US East region"
  type        = string
  default     = "ami-0c2b8ca1dad447f8a" # Ubuntu 20.04 LTS (example, may change)
}

variable "ami_id_us_west" {
  description = "AMI ID for US West region"
  type        = string
  default     = "ami-0d6621c01e8c2de2c" # Ubuntu 20.04 LTS (example, may change)
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}
