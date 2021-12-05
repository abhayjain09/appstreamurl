terraform {
  backend "s3" {
    bucket = "abhayshreyajain-cloud"
    key = "terraform/terraform.tfstate"
    region = "us-west-2"
  }
}