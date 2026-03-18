# this is used to store the state file into the S3 bucket
# Note:
# The S3 bucket should exit before we execute the backend file and if any terraform.tfstate file exits then delte it and run the 
# backend file or else the terraform state will not be stored in the S3 if already exits(state file before the backend execution).


terraform {
  backend "s3" {
    bucket = "divya-terraform-state-file-180326" # when using this backend, the s3 bucket shold created before
    key = "divya/terraform.tfstate"
    region = "us-east-1"    
  }
}

