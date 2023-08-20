# CNFs

This Terraform template will..

- Create ECR repository

keep this, for use if we want a role per repo

module "aws_ecr_roles" {
  source                    = "../../modules/aws-ecr-roles"
  cluster_name              = var.cluster_name
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  cluster_oidc_provider_url = var.cluster_oidc_provider_url
  awsRegion = var.region
  awsAccountId = var.awsAccountId
  service_account = var.service_account
  namespace = var.sa_namespace
}
