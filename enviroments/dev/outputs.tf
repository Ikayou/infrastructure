output "application_url" {
  value = "http://localhost:8080"
}

output "postgres_container" {
  value = docker_container.postgres.name
}

output "backend_container" {
  value = docker_container.backend.name
}

output "nginx_container" {
  value = docker_container.nginx.name
}