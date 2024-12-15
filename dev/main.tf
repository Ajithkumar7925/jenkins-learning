module "ec2_module" {
  source = "../modules/ec2-module"
  inst_type = var.inst_type
}