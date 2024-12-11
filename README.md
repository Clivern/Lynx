<p align="center">
    <img alt="Lynx Logo" src="/assets/img/logo.png?v=0.12.3" width="400" />
    <h3 align="center">Lynx</h3>
    <p align="center">A Fast, Secure and Reliable Terraform Backend, Set up in Minutes.</p>
    <p align="center">
        <a href="https://github.com/Clivern/Lynx/actions/workflows/ci.yml">
            <img src="https://github.com/Clivern/Lynx/actions/workflows/server_ci.yml/badge.svg"/>
        </a>
        <a href="https://github.com/Clivern/Lynx/releases">
            <img src="https://img.shields.io/badge/Version-0.12.3-1abc9c.svg">
        </a>
        <a href="https://hub.docker.com/r/clivern/lynx/tags">
            <img src="https://img.shields.io/badge/Docker-0.12.3-1abc9c.svg">
        </a>
        <a href="https://github.com/Clivern/terraform-provider-lynx">
            <img src="https://img.shields.io/badge/Terraform-Provider-yellow.svg">
        </a>
        <a href="https://github.com/Clivern/Lynx/blob/main/LICENSE">
            <img src="https://img.shields.io/badge/LICENSE-MIT-orange.svg">
        </a>
    </p>
</p>
<br/>

Lynx is a Fast, Secure and Reliable Terraform Backend. It is built in Elixir with Phoenix framework.

#### Features:

- Simplified Setup: Easy installation and maintenance for hassle-free usage.
- Team Collaboration: Manage multiple teams and users seamlessly.
- User-Friendly Interface: Enjoy a visually appealing dashboard for intuitive navigation.
- Project Flexibility: Support for multiple projects within each team.
- Environment Management: Create and manage multiple environments per project.
- State Versioning: Keep track of Terraform state versions for better control.
- Rollback Capability: Easily revert to previous states for efficient infrastructure management.
- Terraform Locking Support: The project also supports Terraform locking, ensuring state integrity and preventing concurrent operations that could lead to data corruption
- [RESTful Endpoints](https://lynx.apidocumentation.com/reference): for seamless teams, users, projects, environments, and snapshots management.
- Snapshots Support: for both projects and environments to ensure data integrity and provide recovery options at specific points in time.
- [Terraform Provider](https://github.com/Clivern/terraform-provider-lynx): Automate creation/updates of teams, users, projects, environments and snapshots with terraform.

#### Upcoming Features:

- Single Sign-On (SSO): Support for OAuth2 Providers like Azure AD OAuth, Keycloak, Okta ... etc


#### Quick Start

> [!IMPORTANT]
>
> Make sure you have docker and docker-compose installed for the quick start.

Lynx requires a [PostgreSQL](https://www.postgresql.org/) database. No Object Storage is required.

To run `Lynx` alone on port `4000` on docker.

```bash
$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/docker-compose.yml \
    -O docker-compose.yml

$ docker-compose up -d
```

To run `Lynx` behind nginx reverse proxy on port `80` on docker.

```bash
$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/docker-compose-nginx.yml \
    -O docker-compose.yml
$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/nginx.conf \
    -O nginx.conf

$ docker-compose up -d
```

To run a 3 Nodes of `Lynx` behind nginx reverse proxy on port `80` on docker.

```bash
$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/docker-compose-cluster.yml \
    -O docker-compose.yml
$ wget https://raw.githubusercontent.com/Clivern/Lynx/main/nginx-cluster.conf \
    -O nginx-cluster.conf

$ docker-compose up -d
```

Here is a [video demonstration](https://www.youtube.com/watch?v=YNkHfysr3-0)


#### Manual Installation

Please check [this guide](https://lynx.clivern.com/documentation/Installation/) for a manual setup on Ubuntu server.


#### Important Links

| Name             | Description                                                                                        |
| ---------------- | -------------------------------------------------------------------------------------------------- |
| API Documentation| [https://lynx.apidocumentation.com/reference](https://lynx.apidocumentation.com/reference)
| Bug Tracker      | [Submit issues on GitHub](https://github.com/clivern/lynx/issues)                                  |
| Security Issues  | [Submit security vulnerability on GitHub](https://github.com/Clivern/Lynx/security/advisories/new) |
| Contributing     | [Read the contribution guide here](./docs/how-to/development/Reamd.md)                             |


#### License

© 2023, Clivern. Released under [MIT License](https://opensource.org/licenses/mit-license.php).

Lynx is authored and maintained by [@clivern](http://github.com/clivern).
