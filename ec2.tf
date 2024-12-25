terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
# data "aws_ami" "aws_linux" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "platform-details"
#     values = ["Linux/UNIX"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

resource "aws_instance" "web" {
  ami           = "ami-0e2c8caa4b6378d8c"
  instance_type = var.inst_type

  key_name      = "jenkins_key_pair"
  vpc_security_group_ids = [ "sg-0f84f97a4131de9cb" ]

#   user_data = <<EOF
#             sudo apt update
#             sudo apt install fontconfig openjdk-17-jre
#             java -version
# EOF

  tags = {
    Name = "Jenkins_Server"
  }
}