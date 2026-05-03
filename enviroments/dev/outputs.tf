output "application_url" {
  description = "URL to access the application"
  value       = "http://localhost:${module.nginx_dev.assigned_port}"
}