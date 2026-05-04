variable "image_name" {
  description = "Docker image name"
  type        = string
}

variable "container_name" {
  description = "Docker container name"
  type        = string
}

variable "internal_port" {
  description = "container port number to expose"
  type        = number
  default     = 80
}

variable "external_port" {
  description = "host port number to bind to"
  type        = number
}

variable "network_name" {
  description = "Docker network name to connect"
  type        = string
}

variable "env_vars" {
  description = "Environment variables for the container"
  type        = list(string)
  default     = []
}