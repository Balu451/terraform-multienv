provider "aws" {
  region = "us-east-1"
}

module "network" {
  source      = "../../modules/network"
  vpc_cidr    = "10.2.0.0/16"
  subnet_cidr = "10.2.1.0/24"
  az          = "us-east-1c"
  env         = "prod"
  ami_id         = "ami-0c7217cdde317cfec"
  instance_type  = "t2.micro"
}
