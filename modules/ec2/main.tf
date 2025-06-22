resource "aws_key_pair" "terraform_key_new" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "nodejs" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                   = aws_key_pair.terraform_key_new.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  tags = {
    Name = "${var.env}-nodejs-instance"
  }

  user_data = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y curl git
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs
    npm install -g pm2
    cd /home/ubuntu
    if [ ! -d "my-node-app" ]; then
      git clone https://github.com/yourusername/my-node-app.git
    fi
    cd my-node-app
    npm install
    pm2 start app.js --name "node-app"
    pm2 startup systemd
    pm2 save
    systemctl enable pm2-ubuntu
  EOT
}

