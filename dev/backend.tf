terraform {
  backend "s3" {
    bucket = "terraform-aws-learning"
    key    = "jenkins-server-env/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-locking"
  }
}
