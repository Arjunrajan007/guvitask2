# VPC and networking for US East (N. Virginia)
resource "aws_vpc" "vpc_us_east" {
  provider   = aws.us_east
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-us-east"
  }
}

resource "aws_subnet" "subnet_us_east" {
  provider                = aws.us_east
  vpc_id                  = aws_vpc.vpc_us_east.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-us-east"
  }
}

resource "aws_internet_gateway" "igw_us_east" {
  provider = aws.us_east
  vpc_id   = aws_vpc.vpc_us_east.id

  tags = {
    Name = "igw-us-east"
  }
}

resource "aws_route_table" "rt_us_east" {
  provider = aws.us_east
  vpc_id   = aws_vpc.vpc_us_east.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_us_east.id
  }

  tags = {
    Name = "rt-us-east"
  }
}

resource "aws_route_table_association" "rta_us_east" {
  provider       = aws.us_east
  subnet_id      = aws_subnet.subnet_us_east.id
  route_table_id = aws_route_table.rt_us_east.id
}

# Security Group for US East
resource "aws_security_group" "sg_us_east" {
  provider = aws.us_east
  name     = "web-sg-us-east"
  vpc_id   = aws_vpc.vpc_us_east.id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg-us-east"
  }
}

# EC2 instance in US East
resource "aws_instance" "web_us_east" {
  provider                   = aws.us_east
  ami                        = var.ami_us_east
  instance_type              = var.instance_type
  subnet_id                  = aws_subnet.subnet_us_east.id
  vpc_security_group_ids     = [aws_security_group.sg_us_east.id]
  associate_public_ip_address = true

  tags = {
    Name = "WebServer-US-East"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
}

# VPC and networking for US West (Oregon)
resource "aws_vpc" "vpc_us_west" {
  provider   = aws.us_west
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "vpc-us-west"
  }
}

resource "aws_subnet" "subnet_us_west" {
  provider                = aws.us_west
  vpc_id                  = aws_vpc.vpc_us_west.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "subnet-us-west"
  }
}

resource "aws_internet_gateway" "igw_us_west" {
  provider = aws.us_west
  vpc_id   = aws_vpc.vpc_us_west.id

  tags = {
    Name = "igw-us-west"
  }
}

resource "aws_route_table" "rt_us_west" {
  provider = aws.us_west
  vpc_id   = aws_vpc.vpc_us_west.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_us_west.id
  }

  tags = {
    Name = "rt-us-west"
  }
}

resource "aws_route_table_association" "rta_us_west" {
  provider       = aws.us_west
  subnet_id      = aws_subnet.subnet_us_west.id
  route_table_id = aws_route_table.rt_us_west.id
}

# Security Group for US West
resource "aws_security_group" "sg_us_west" {
  provider = aws.us_west
  name     = "web-sg-us-west"
  vpc_id   = aws_vpc.vpc_us_west.id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg-us-west"
  }
}

# EC2 instance in US West
resource "aws_instance" "web_us_west" {
  provider                   = aws.us_west
  ami                        = var.ami_us_west
  instance_type              = var.instance_type
  subnet_id                  = aws_subnet.subnet_us_west.id
  vpc_security_group_ids     = [aws_security_group.sg_us_west.id]
  associate_public_ip_address = true

  tags = {
    Name = "WebServer-US-West"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
}

# Output the public IP addresses of both instances
output "web_us_east_public_ip" {
  value       = aws_instance.web_us_east.public_ip
  description = "Public IP of US East EC2 instance"
}

output "web_us_west_public_ip" {
  value       = aws_instance.web_us_west.public_ip
  description = "Public IP of US West EC2 instance"
}
