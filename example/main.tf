terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }

  backend "http" {
    address = "http://localhost:4000/api/v1/pard/prod/state"
    lock_address = "http://localhost:4000/api/v1/pard/prod/lock"
    unlock_address = "http://localhost:4000/api/v1/pard/prod/unlock"
    lock_method = "POST"
    unlock_method = "POST"
  }

  required_version = "= 1.3.7"
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
