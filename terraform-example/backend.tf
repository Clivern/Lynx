terraform {
  backend "http" {
    username       = "hs2d21pk"
    password       = "pO(BwDTjs5ND"
    address        = "http://localhost:4000/client/clivern/monitoring/prod/state"
    lock_address   = "http://localhost:4000/client/clivern/monitoring/prod/lock"
    unlock_address = "http://localhost:4000/client/clivern/monitoring/prod/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}