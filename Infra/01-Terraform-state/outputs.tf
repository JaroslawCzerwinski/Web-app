output "web_app_ecr_repo_uri" {
  value       = aws_ecr_repository.web_app.repository_url
  description = "The URI of the Amazon ECR repository for the web application."
}