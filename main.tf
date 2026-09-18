provider "aws" {
  region = var.region
}

resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Custom_IGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }
  tags = {
    Name = "Public_RT"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.subnet2_cidr
  availability_zone = var.az1

  tags = {
    Name = "Subnet2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnet3_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet3"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.subnet4_cidr
  availability_zone = var.az2

  tags = {
    Name = "Subnet4"
  }
}

resource "aws_route_table_association" "subnet1_ass" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "subnet3_ass" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "ec2_sg" {
  name        = var.sg_name
  description = "Allow Access to EC2"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
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
    Name = "EC2_SG"
  }
}

/*

resource "aws_instance" "public_ec2" {
  ami                    = var.ec2_ami
  instance_type          = var.instance_type
  key_name               = var.ec2_key_pair
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Public_EC2"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = var.ec2_ami
  instance_type          = var.instance_type
  key_name               = var.ec2_key_pair
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Private_EC2"
  }
}

resource "aws_eip" "natgw_eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "custom_natgw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = aws_subnet.subnet1.id

  tags = {
    Name = "CUSTOM_NAT_GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.custom_igw]
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.custom_natgw.id
  }
  tags = {
    Name = "Private_RT"
  }
}

resource "aws_route_table_association" "subnet2_ass" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "subnet4_ass" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.private_rt.id
}
*/