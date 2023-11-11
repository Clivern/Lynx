#### How to use Lynx as a backend

After creating a project and environment in lynx dashboard. You can get the backend information and secrets to use. it should be something like the following

```hcl
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
```

Copy the `address`, `lock_address`, `unlock_address`, `lock_method` and `unlock_method` and place it in `backend.tf` file like the following

```hcl
terraform {
  backend "http" {
    address        = "http://localhost:4000/client/clivern/monitoring/prod/state"
    lock_address   = "http://localhost:4000/client/clivern/monitoring/prod/lock"
    unlock_address = "http://localhost:4000/client/clivern/monitoring/prod/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}
```

Username and password should be define as environment variables.

```zsh
$ export TF_HTTP_USERNAME="vf41bkwj"
$ export TF_HTTP_PASSWORD="2sTb&N*gvyXj"
```

Then you can check the changes and apply them

```zsh
$ terraform plan
$ terraform apply
```
