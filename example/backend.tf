terraform {
  backend "http" {
    address        = "http://localhost:4000/client/clivern/grafana_infra/prod/state"
    lock_address   = "http://localhost:4000/client/clivern/grafana_infra/prod/lock"
    unlock_address = "http://localhost:4000/client/clivern/grafana_infra/prod/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}
