module "nginx_dev" {
  source         = "../../modules/docker_base"
  
  image_name     = var.dev_image
  container_name = var.dev_container_name
  external_port  = var.dev_port
  internal_port  = 80
}