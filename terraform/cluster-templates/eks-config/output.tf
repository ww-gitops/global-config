
output "cluster_path" {
  description = "path to cluster files in management repository"
  value       = var.target_path
}

output "secret_name" {
  description = "name of secret in vault containing kubeconfig"
  value       = module.leaf_config.secret_name
}

output "ecr_role" {
  description = "ecr role arn"
  value       = module.aws_ecr_roles.role_arn
}