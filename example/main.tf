terraform {
  required_providers {}

  backend "http" {
    username = "arv5w7pc"
    password = "#k7zR7akXhpF"
    address = "http://localhost:4000/client/lynx/nagios/prod/state"
    lock_address = "http://localhost:4000/client/lynx/nagios/prod/lock"
    unlock_address = "http://localhost:4000/client/lynx/nagios/prod/unlock"
    lock_method = "POST"
    unlock_method = "POST"
  }

  required_version = "1.3.7"
}

provider "local" {
}

resource "local_file" "hello_world" {
  content  = "Hello, World!"
  filename = "${path.module}/hello.txt"
}
