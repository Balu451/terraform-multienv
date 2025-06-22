terraform {
  backend "s3" {
    bucket = "my-terraform-state-staging"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
