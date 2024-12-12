---
# Page settings
layout: documentation-single
title: Installation
description: In this section you'll find basic information about Lynx and how to install it and use it properly. If you're first time user then you should read this section first.
keywords: terraform-backend, lynx, terraform, clivern
comments: false
order: 1
hero:
    title: Installation
    text: In this section you'll find basic information about Lynx and how to install it and use it properly. If you're first time user then you should read this section first.
---

## What is Lynx?

Lynx is a Fast, Secure and Reliable Terraform Backend. A Terraform backend is a resource that stores the state file for a Terraform configuration. The state file is a crucial component in Terraform, as it keeps track of the resources created by your configuration and their metadata. This allows Terraform to map the real-world resources to the configuration, perform reconciliation, and plan future changes.

There are two main types of Terraform backends:

- Local Backend: This is the default backend where the state file is stored locally on the filesystem. It's suitable for small, single-user configurations but not recommended for team environments or production use due to the risk of state file corruption or conflicts.
- Remote Backends: These backends store the state file in a remote, shared storage location like cloud storage services (e.g., AWS S3, Azure Blob Storage), HashiCorp Terraform Cloud, or a database. Remote backends are essential for team collaboration, enforcing state locking to prevent corruptions, and providing durability and backups for state files.

Some key benefits of using remote backends include:

- Collaboration: Multiple users can access and update the same state file concurrently without conflicts or corruption.
- State Locking: Prevents concurrent operations from corrupting the state file by allowing only one user to modify it at a time.
- Encryption: Many remote backends support encrypting the state file at rest for enhanced security.
- Versioning: Some backends support state file versioning, allowing you to revert to previous versions if needed.


## Lynx Features

- Simplified Setup: Easy installation and maintenance for hassle-free usage.
- Team Collaboration: Manage multiple teams and users seamlessly.
- User-Friendly Interface: Enjoy a visually appealing dashboard for intuitive navigation.
- Project Flexibility: Support for multiple projects within each team.
- Environment Management: Create and manage multiple environments per project.
- State Versioning: Keep track of Terraform state versions for better control.
- Rollback Capability: Easily revert to previous states for efficient infrastructure management.
- Terraform Locking Support: The project also supports Terraform locking, ensuring state integrity and preventing concurrent operations that could lead to data corruption
- RESTful Endpoints: for seamless teams, users, projects, environments, and snapshots management.
- Snapshots Support: for both projects and environments to ensure data integrity and provide recovery options at specific points in time.
- [Terraform Provider](https://github.com/Clivern/terraform-provider-lynx): Automate creation/updates of teams, users, projects, environments and snapshots with terraform.
- Single Sign-On (SSO): Support for OAuth2 Providers like Azure AD OAuth, Keycloak, Okta ... etc


## Why Lynx?

There are several compelling reasons to choose a custom Terraform backend over AWS `S3`, `PostgreSQL`, or `Terraform Cloud`, especially when considering the cost:

- Team Collaboration and User Management: The custom backend offers robust team collaboration and user management capabilities, which can be particularly valuable for organizations with multiple teams and users working on different projects. This feature is not readily available in AWS S3 or PostgreSQL backends, and while Terraform Cloud provides similar functionality, it comes at a cost.

- Project and Environment Management: The ability to manage multiple projects and environments within each project is a significant advantage. This level of organization and separation can be challenging to achieve with AWS S3 or PostgreSQL backends, and Terraform Cloud's pricing model can become expensive for organizations with numerous projects and environments.

- State Versioning and Rollback: The state versioning and rollback capabilities provided by the custom backend can be invaluable for maintaining control over your infrastructure and ensuring data integrity. While AWS S3 and PostgreSQL backends offer some versioning capabilities, the custom backend's rollback feature can simplify the process of reverting to previous states, potentially saving time and effort.

- RESTful Endpoints and Automation: The availability of RESTful endpoints and a Terraform provider can greatly simplify the automation and management of teams, users, projects, environments, and snapshots. This level of automation can be challenging to achieve with AWS S3 or PostgreSQL backends and may require additional tooling or custom scripts.

- Authentication Support: The support for OAuth2 authentication providers like Azure AD, Keycloak, and Okta can be a significant advantage for organizations with existing authentication infrastructure or specific security requirements. Integrating with these providers can be more complex with AWS S3 or PostgreSQL backends.


## Deployment

#### With docker and docker compose

Lynx requires a [PostgreSQL](https://www.postgresql.org/) database. No Object Storage is required.

To run `Lynx` alone on port `4000` on docker.

```bash
$ apt-get install docker.io docker-compose -y

$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/docker-compose.yml \
    -O docker-compose.yml

$ docker-compose up -d
```

To run `Lynx` behind nginx reverse proxy on port `80` on docker.

```bash
$ apt-get install docker.io docker-compose -y

$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/docker-compose-nginx.yml \
    -O docker-compose.yml
$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/nginx.conf \
    -O nginx.conf

$ docker-compose up -d
```

To run a 3 Nodes of `Lynx` behind nginx reverse proxy on port 80 on docker.

```bash
$ apt-get install docker.io docker-compose -y

$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/docker-compose-cluster.yml \
    -O docker-compose.yml
$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/nginx-cluster.conf \
    -O nginx-cluster.conf

$ docker-compose up -d
```

Then go to the public URL (for example `http://lynx.sh/` or `http://localhost` or `http://localhost:4000`) and provide the required informtaion to install Lynx.


#### Manually on Ubuntu

- Install `elixir`, `erlang` and `PostgreSQL`

```zsh
$ apt-get update
$ apt-get upgrade -y
$ apt-get install -y postgresql \
    elixir \
    erlang-dev \
    make \
    build-essential \
    erlang-os-mon \
    inotify-tools \
    erlang-xmerl
```

- Setup `PostgreSQL` database, username and password

```zsh
# Create PostgreSQL user with password
$ sudo -u postgres psql -c "CREATE USER lynx WITH PASSWORD 'lynx';"
$ sudo -u postgres psql -c "ALTER USER lynx CREATEDB;"

# Create database
$ sudo -u postgres psql -c "CREATE DATABASE lynx_dev OWNER lynx;"
```

- Configure Environment Variables: Set up the required environment variables from `.env.example`.

```zsh
$ mkdir -p /etc/lynx
$ cd /etc/lynx
$ git clone https://github.com/Clivern/Lynx.git app
$ cd /etc/lynx/app
$ cp .env.example .env.local # Adjust the database configs and application port to be 80 for example
```

- Install dependencies and migrate the database

```zsh
$ make deps
$ make migrate
```

- Create a systemd service file `/etc/systemd/system/lynx.service`

```zsh
[Unit]
Description=Lynx

[Service]
Type=simple
Environment=HOME=/root
EnvironmentFile=/etc/lynx/app/.env.local
WorkingDirectory=/etc/lynx/app
ExecStart=/usr/bin/mix phx.server

[Install]
WantedBy=multi-user.target
```

```zsh
$ systemctl enable lynx.service
$ systemctl start lynx.service
```

Then go to the public URL (for example `http://lynx.sh/` or `http://localhost` or `http://localhost:4000`) and provide the required informtaion to install Lynx.


![Image](/assets/images/install_page.png)

![Image](/assets/images/home_page.png)
