provider "aws" {
  region = "us-east-1"
}

module "network" {
  source      = "../../modules/network"
  vpc_cidr    = "10.1.0.0/16"
  subnet_cidr = "10.1.1.0/24"
  az          = "us-east-1b"
  env         = "staging"
  ami_id         = "ami-0c7217cdde317cfec"  # Use latest Amazon Linux 2 AMI for your region
  instance_type  = "t2.micro"
}
