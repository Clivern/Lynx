---
# Page settings
layout: documentation-single
title: Usage
description: In this section you will learn how to create users, teams, projects, environments and snapshots.
keywords: terraform-backend, lynx, terraform, clivern
comments: false
order: 3
hero:
    title: Usage
    text: In this section you will learn how to create users, teams, projects, environments and snapshots.
---

## Usage

After we created a user, team, project and environment, You can use the environment terraform backend configuration as follows

![Image](/assets/images/show_env_page.png)

It should be something like the following

```hcl
terraform {
  backend "http" {
    // Best to define as environment variable $ export TF_HTTP_USERNAME=vf41bkwj
    username       = "vf41bkwj"
    // Best to define as environment variable $ export TF_HTTP_PASSWORD=2sTb&N*gvyXj
    password       = "2sTb&N*gvyXj"
    address        = "http://localhost:4000/client/data-platform/monitoring/prod/state"
    lock_address   = "http://localhost:4000/client/data-platform/monitoring/prod/lock"
    unlock_address = "http://localhost:4000/client/data-platform/monitoring/prod/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}
```

Copy the `address`, `lock_address`, `unlock_address`, `lock_method` and `unlock_method` and place it in `backend.tf` file like the following

```hcl
terraform {
  backend "http" {
    address        = "http://localhost:4000/client/data-platform/monitoring/prod/state"
    lock_address   = "http://localhost:4000/client/data-platform/monitoring/prod/lock"
    unlock_address = "http://localhost:4000/client/data-platform/monitoring/prod/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}
```

`Username` and `password` should be define as environment variables.

```
$ export TF_HTTP_USERNAME="vf41bkwj"
$ export TF_HTTP_PASSWORD="2sTb&N*gvyXj"
```

Then you can check the changes and apply them

```
$ terraform plan
$ terraform apply
```

Here is the [full working example](https://github.com/Clivern/Lynx/tree/main/example)
