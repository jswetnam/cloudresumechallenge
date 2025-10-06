terraform {
  backend "s3" {
    bucket = "tfstate-cloudresumechallenge"
    key = "cloudresumechallenge/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}