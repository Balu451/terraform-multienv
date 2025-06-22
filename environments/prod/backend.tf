terraform {
  backend "s3" {
    bucket = "my-terraform-state-"prod"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
