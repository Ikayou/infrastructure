output "container_id" {
  description = "ID of the running container"
  value       = docker_container.app_container.id
}

output "assigned_port" {
  description = "host port number assigned to the container"
  value       = var.external_port
}