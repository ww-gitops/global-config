
output "repository_arn" {
  description = "repository ARN"
  value       = aws_ecr_repository.repo.arn
}

output "repository_url" {
  description = "repository URL"
  value       = aws_ecr_repository.repo.repository_url
}

output "registry_id" {
  description = "Registry ID"
  value       = aws_ecr_repository.repo.registry_id
}
