terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.25.0"
    }
  }

  backend "http" {
    username = "admin"
    password = "secret"
    address = "http://localhost:4000/api/v1/bandit/prod/state"
    lock_address = "http://localhost:4000/api/v1/bandit/prod/lock"
    unlock_address = "http://localhost:4000/api/v1/bandit/prod/unlock"
    lock_method = "POST"
    unlock_method = "POST"
  }

  required_version = "1.7.3"
}

provider "docker" {}

variable "app_image" {
  type        = string
  description = "The docker image name"
  default     = "nginx"
}

variable "app_version" {
  type        = string
  description = "The docker image version"
  default     = "latest"
}
