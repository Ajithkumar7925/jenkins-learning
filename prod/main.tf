resource "aws_cloudwatch_log_group" "jenkins-cw-log" {
  name = "jenkins-cw-log"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}