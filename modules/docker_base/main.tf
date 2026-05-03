terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.8"
    }
  }
}

resource "docker_image" "app_image" {
  name = var.image_name
}

resource "docker_container" "app_container" {
  image = docker_image.app_image.image_id
  name  = var.container_name
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}