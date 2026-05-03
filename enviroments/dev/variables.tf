variable "dev_image" {
  description = "dev environment image name"
  type        = string
  default     = "nginx:latest"
}

variable "dev_container_name" {
  description = "dev environment container name"
  type        = string
  default     = "dev-portfolio-app"
}

variable "dev_port" {
  description = "dev environment port"
  type        = number
  default     = 8080
}