
provider "google" {
  region = "${var.gcp_region}"
}

# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE S3 AS A BACKEND
# Note that this has been commented out because of a slightly awkward chicken and egg: you must first apply this
# module without a backend to create the S3 bucket and DynamoDB table and only then can you uncomment the section
# below and run terraform init to use this module with a backend.
# ---------------------------------------------------------------------------------------------------------------------

#terraform {
#  backend "s3" {
#    region         = "us-east-1"
#    bucket         = "iac-workshop-example-bucket"
#    key            = "exercise-02a/terraform.tfstate"
#    encrypt        = true
#    dynamodb_table = "terraform-locks-example"
#  }

resource "google_storage_bucket" "static-site" {
  name     = "tfbucket"
  location = "US"
  force_destroy = true
  
  lifecycle_rule { 
    condition {
      age = 3
    }
    action { 
      type = "Delete"
    }
  }
 
# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE DYNAMODB TABLE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_dynamodb_table" "terraform_locks" {
  name           = "${var.dynamodb_lock_table_name}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
