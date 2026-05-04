resource "docker_network" "app_network" {
  name = "dev-app-network"
}

resource "docker_volume" "postgres_data" {
  name = "dev-postgres-data"
}

resource "docker_image" "postgres" {
  name = "postgres:16"
}

resource "docker_container" "postgres" {
  name  = "dev-postgres"
  image = docker_image.postgres.name

  env = [
    "POSTGRES_DB=appdb",
    "POSTGRES_USER=appuser",
    "POSTGRES_PASSWORD=apppassword"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }
}

resource "docker_image" "backend" {
  name = "dev-fastapi-backend:latest"

  build {
    context = abspath("${path.module}/../../backend")
  }

  triggers = {
    rebuild = timestamp()
  }

  healthcheck {
    test     = ["CMD", "wget", "-qO-", "http://localhost:8000/health"]
    interval = "10s"
    timeout  = "3s"
    retries  = 3
  }

}

resource "docker_container" "backend" {
  name  = "dev-backend"
  image = docker_image.backend.name

  env = [
    "DB_HOST=dev-postgres",
    "DB_NAME=appdb",
    "DB_USER=appuser",
    "DB_PASSWORD=apppassword"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [
    docker_container.postgres
  ]
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "dev-nginx"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    host_path      = abspath("${path.module}/nginx.conf")
    container_path = "/etc/nginx/nginx.conf"
  }

  depends_on = [
    docker_container.backend
  ]
}