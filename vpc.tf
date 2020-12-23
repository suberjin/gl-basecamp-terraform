resource "aws_vpc" "homework" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "homework"
  }
}

resource "aws_internet_gateway" "homework-ig" {
  vpc_id = aws_vpc.homework.id

  tags = {
    Name = "homework-ig"
  }
}

resource "aws_route_table" "homework_rt" {
  vpc_id = aws_vpc.homework.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.homework-ig.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "homework_1" {
  vpc_id     = aws_vpc.homework.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Homework"
  }
}

resource "aws_subnet" "homework_2" {
  vpc_id     = aws_vpc.homework.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Homework"
  }
}

resource "aws_route_table_association" "us-west-2a" {
  subnet_id      = aws_subnet.homework_1.id
  route_table_id = aws_route_table.homework_rt.id
}

resource "aws_route_table_association" "us-west-2b" {
  subnet_id      = aws_subnet.homework_2.id
  route_table_id = aws_route_table.homework_rt.id
}

resource "aws_security_group" "allow_web_rules" {
  name        = "allow_rules"
  description = "Allow Rules"
  vpc_id      = aws_vpc.homework.id

  ingress {
    description = "allow_rules_nginx"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow_rules_ssh"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_web_rules"
  }
}

resource "aws_security_group" "allow_ssh_rules" {
  name        = "allow_ssh_rules"
  description = "Allow Rules"
  vpc_id      = aws_vpc.homework.id

  ingress {
    description = "allow_rules_ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["109.87.77.192/32"]
  }

  tags = {
    Name = "allow_ssh_rules"
  }
}