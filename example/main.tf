terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }

  backend "http" {
    address = "http://localhost:4000/api/v1/civet/v1/state"
    lock_address = "http://localhost:4000/api/v1/civet/v1/lock"
    unlock_address = "http://localhost:4000/api/v1/civet/v1/unlock"
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

variable "app_name" {
  type        = string
  description = "The container name"
  default     = "app_dev"
}

variable "app_port" {
  type        = string
  description = "The external port"
  default     = 8001
}
