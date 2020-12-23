terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 2.70"
    }
  }
}

variable "region" {
  default = "us-west-2"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

# resource "aws_instance" "worker" {
#   for_each      = aws_subnet.public
#   ami           = data.aws_ami.ec2.id
#   instance_type = var.tableau_instance
#   key_name      = aws_key_pair.main.key_name
#   subnet_id     = each.value.id
# }