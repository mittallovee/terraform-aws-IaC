# Store Terraform state file in aws s3
terraform {
  backend "s3" {
    bucket = "terraform-backend-testing-aws"
    key    = "terraform-aws-iac.terraform"
    region = "ap-south-1"
  }
}