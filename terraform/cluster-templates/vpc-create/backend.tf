terraform {
  backend "s3" {
    bucket         = "ww-prc-mac-749339757188-eu-west-1-tf-state"
    key            = "ww-paulc-mac/test-one/vpc/t1-v1/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "ww-prc-mac-749339757188-eu-west-1-tf-state"
  }
}