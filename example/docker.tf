
locals {
  distr = "${var.app_image}:${var.app_version}"
  port  = 8000
}

resource "docker_image" "nginx" {
  name         = local.distr
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = var.app_name
  ports {
    internal = local.port
    external = var.app_port
  }
}
