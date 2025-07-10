provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
}

resource "aws_instance" "us_east_instance" {
  provider          = aws.us_east
  ami               = var.ami_id_us_east
  instance_type     = var.instance_type
  availability_zone = "us-east-1a"
  tags = {
    Name = "EC2-US-EAST"
  }
}

resource "aws_instance" "us_west_instance" {
  provider          = aws.us_west
  ami               = var.ami_id_us_west
  instance_type     = var.instance_type
  availability_zone = "us-west-2a"
  tags = {
    Name = "EC2-US-WEST"
  }
}
