terraform {
  backend "s3" {
    bucket = "terraform-aws-learning"
    key    = "jenkins-server-prod/terraform.tfstate"
    region = "us-east-1"
  }
}