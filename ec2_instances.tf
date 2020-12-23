variable "ami" {
  default = "ami-0a36eb8fadc976275"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "awslearn3.oregon"
}


resource "aws_instance" "worker_1" {
  ami           = var.ami
  instance_type = var.instance_type
  availability_zone = "us-west-2a"
  subnet_id = aws_subnet.homework_1.id
  key_name = var.key_name
  user_data = data.template_file.instance.rendered
  associate_public_ip_address = "true"

  tags = {
    Name = "Worker1"
  }
}

resource "aws_instance" "worker_2" {
  ami           = var.ami
  instance_type = var.instance_type
  availability_zone = "us-west-2b"
  subnet_id = aws_subnet.homework_2.id
  key_name = var.key_name
  user_data = data.template_file.instance.rendered
  associate_public_ip_address = "true"

  tags = {
    Name = "Worker2"
  }
}

data "template_file" "instance" {
  template = file("${path.module}/user-data/instance.tpl")
}