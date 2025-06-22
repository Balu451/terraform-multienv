provider "aws" {
  region = "us-east-1"
}

module "network" {
  source      = "../../modules/network"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  az          = "us-east-1a"
  env         = var.env
}

resource "aws_key_pair" "terraform_key_new" {
  key_name   = "terraform_key_new"
  public_key = file("C:/Users/balu0/.ssh/terraform_key_new.pub")
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.env}-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["207.81.47.23/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-ec2-sg"
  }
}

module "ec2" {
  source             = "../../modules/ec2"
  env                = var.env
  ami_id             = "ami-0c7217cdde317cfec"
  instance_type      = "t2.micro"
  key_name           = aws_key_pair.terraform_key_new.key_name
  public_key_path    = "C:/Users/balu0/.ssh/terraform_key_new.pub"
  subnet_id          = module.network.subnet_id
  security_group_ids = [aws_security_group.ec2_sg.id]
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
module "rds" {
  source = "../../modules/rds"

  name                  = "dev-rds-instance"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password

  subnet_ids            = module.network.private_subnet_ids

  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible   = false

  tags = {
    Environment = var.env
    Name        = "dev-rds-instance"
  }
}

