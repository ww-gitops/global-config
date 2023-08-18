
output "cluster_path" {
  description = "path to cluster files in management repository"
  value       = var.target_path
}

output "secret_name" {
  description = "name of secret in vault containing kubeconfig"
  value       = module.leaf_config.secret_name
}

output "cluster_oidc_provider_arn" {
  data.aws_iam_openid_connect_provider.this.arn
}

output "cluster_oidc_provider_url" {
  data.aws_iam_openid_connect_provider.this.url
}
