# set up S3 bucket for statefiles

provider "aws" {
  region = var.region
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform{
  backend "s3"{
    bucket = "plamosi-terraform-state"
    key = "terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
