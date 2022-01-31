
locals {
  distr = "${var.app_image}:${var.app_version}"
  port  = 8000
}

resource "docker_image" "nginx" {
  name         = local.distr
  keep_locally = false
}
