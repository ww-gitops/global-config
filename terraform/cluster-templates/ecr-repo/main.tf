provider "aws" {
  region = var.region

  default_tags {
    tags = merge({
      source  = "Terraform Managed"
      repo = var.repo_name
    }, var.tags)
  }
}

resource "aws_ecr_repository" "repo" {
  name                 = var.repo_name
}