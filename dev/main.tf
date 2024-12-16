module "ec2_module" {
  source = "../modules/ec2-module"
  inst_type = var.inst_type
}

resource "aws_cloudwatch_log_group" "jenkins-cw-log" {
  name = "jenkins-cw-log"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}