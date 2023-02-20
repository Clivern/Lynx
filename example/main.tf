terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }

  backend "http" {
    username       = "hs2d21pk"
    password       = "pO(BwDTjs5ND"
    address        = "http://localhost:4000/client/clivern/monitoring/prod/state"
    lock_address   = "http://localhost:4000/client/clivern/monitoring/prod/lock"
    unlock_address = "http://localhost:4000/client/clivern/monitoring/prod/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }

  required_version = "1.3.7"
}

provider "local" {}

resource "local_file" "hello_world" {
  content  = "Hello, World!"
  filename = "${path.module}/hello.txt"
}

provider "time" {}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on      = [null_resource.previous]
  create_duration = "30s"
}
