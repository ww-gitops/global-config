
output "ecr_role_arn" {
  description = "repository role ARN"
  value       = module.aws_ecr_roles.role_arn
}

