terraform {
  backend "s3" {
    bucket = "divya-terraform-state-file-180326"
    key = "divya/terraform.tfstate"
    region = "us-east-1"    
  }
}

