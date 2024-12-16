terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
resource "aws_cloudwatch_log_group" "jenkins-cw-log" {
  name = "jenkins-cw-log"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}