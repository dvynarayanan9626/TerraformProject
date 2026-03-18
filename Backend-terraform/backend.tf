terraform {
  backend "s3" {
    bucket = "divya-terraform-state-file-180326" # when using this backend, the s3 bucket shold created before
    key = "divya/terraform.tfstate"
    region = "us-east-1"    
  }
}

