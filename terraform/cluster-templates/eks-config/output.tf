
output "cluster_path" {
  description = "path to cluster files in management repository"
  value       = var.target_path
}

# output "secret_name" {
#   description = "name of secret in vault containing kubeconfig"
#   value       = module.leaf_config.secret_name
# }

output "cluster_oidc_provider_arn" {
  value = data.aws_iam_openid_connect_provider.this.arn
}

output "cluster_oidc_provider_url" {
  value = data.aws_iam_openid_connect_provider.this.url
}

output "s3_role" {
  description = "s3 role arn"
  value       = module.aws_s3_roles.role_arn
}
