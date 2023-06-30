
output "repository_arn" {
  description = "repository ARN"
  value       = repo.arn
}

output "repository_url" {
  description = "repository URL"
  value       = repo.repository_url
}

output "registry_id" {
  description = "Registry ID"
  value       = repo.registry_id
}
