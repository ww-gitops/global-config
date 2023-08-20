provider "aws" {
  region = var.awsRegion

  default_tags {
    tags = merge({
      source  = "Terraform Managed"
      repo = var.repo_name
    }, var.tags)
  }
}

resource "aws_ecr_repository" "repo" {
  name                 = var.repo_name
  force_delete         = true
  image_tag_mutability = "IMMUTABLE"
}

module "aws_ecr_roles" {
  source                    = "../../modules/aws-ecr-roles"
  cluster_name              = var.cluster_name
  repo_name               = var.repo_name
  cluster_oidc_provider_arn = data.aws_iam_openid_connect_provider.this.arn
  cluster_oidc_provider_url = data.aws_iam_openid_connect_provider.this.url
  awsRegion = var.region
  awsAccountId = data.aws_caller_identity.current.account_id
  namespace = var.template_namespace
  service_account = var.service_account
}
