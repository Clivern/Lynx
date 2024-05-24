<p align="center">
    <img alt="Lynx Logo" src="/assets/img/logo.png?v=0.11.8" width="180" />
    <h3 align="center">Lynx</h3>
    <p align="center">A Fast, Secure and Reliable Terraform Backend, Set up in Minutes.</p>
    <p align="center">
        <a href="https://github.com/Clivern/Lynx/actions/workflows/ci.yml">
            <img src="https://github.com/Clivern/Lynx/actions/workflows/server_ci.yml/badge.svg"/>
        </a>
        <a href="https://github.com/Clivern/Lynx/releases">
            <img src="https://img.shields.io/badge/Version-0.11.8-1abc9c.svg">
        </a>
        <a href="https://hub.docker.com/r/clivern/lynx/tags">
            <img src="https://img.shields.io/badge/Docker-0.11.8-1abc9c.svg">
        </a>
        <a href="https://github.com/Clivern/terraform-provider-lynx">
            <img src="https://img.shields.io/badge/Terraform-Provider-yellow.svg">
        </a>
        <a href="https://github.com/Clivern/Lynx/actions/workflows/docker.yml">
            <img src="https://github.com/Clivern/Lynx/actions/workflows/docker.yml/badge.svg">
        </a>
        <a href="https://github.com/Clivern/Lynx/blob/main/LICENSE">
            <img src="https://img.shields.io/badge/LICENSE-MIT-orange.svg">
        </a>
    </p>
</p>
<br/>

Lynx is a Fast, Secure and Reliable Terraform Backend. It is built in Elixir with Phoenix framework.

#### Features:

- **Simplified Setup:** Easy installation and maintenance for hassle-free usage.
- **Team Collaboration:** Manage multiple teams and users seamlessly.
- **User-Friendly Interface:** Enjoy a visually appealing dashboard for intuitive navigation.
- **Project Flexibility:** Support for multiple projects within each team.
- **Environment Management:** Create and manage multiple environments per project.
- **State Versioning:** Keep track of Terraform state versions for better control.
- **Rollback Capability:** Easily revert to previous states for efficient infrastructure management.
- **Terraform Locking Support:** The project also supports Terraform locking, ensuring state integrity and preventing concurrent operations that could lead to data corruption
- **RESTful Endpoints:** for seamless teams, users, projects, environments, and snapshots management.
- **Snapshots Support**: for both projects and environments to ensure data integrity and provide recovery options at specific points in time.
- **[Terraform Provider](https://github.com/Clivern/terraform-provider-lynx)**: Automate creation/updates of teams, users, projects, environments and snapshots with terraform.

#### Upcoming Features:

- **OAuth2 Authentication Support:** Support for OAuth2 Providers like Azure AD OAuth, Keycloak, Okta ... etc

## Deployment

Lynx requires a modern postgres version to function. No Object Storage required

### Docker Deployment

To deploy a ready to use stack, you can go to [this docker-compose file](https://github.com/Clivern/Lynx/blob/main/docker-compose.yml) and execute it. All dependencies are already fulfilled. Make sure you update `server_name` in `nginx.conf` file. You can also download it directly via:

```bash
wget https://raw.githubusercontent.com/Clivern/Lynx/main/docker-compose.yml -o docker-compose.yml
docker compose up -d
```

The application will be now available on port 4000 (by default)

### Deploy on Ubuntu

[👉🏻 read here](./docs/how-to/deploy-on-ubuntu/Readme.md)

### Demo Video

Here is a [video demonstration](https://www.youtube.com/watch?v=YNkHfysr3-0)

## Important Links

|                 |                                                                                                    |
| --------------- | -------------------------------------------------------------------------------------------------- |
| Bug Tracker     | [Submit issues on GitHub](https://github.com/clivern/lynx/issues)                                  |
| Security Issues | [Submit security vulnerability on GitHub](https://github.com/Clivern/Lynx/security/advisories/new) |
| Contributing    | [Read the contribution guide here](./docs/how-to/development/Reamd.md)                             |

## License

© 2023, Clivern. Released under [MIT License](https://opensource.org/licenses/mit-license.php).

**Lynx** is authored and maintained by [@clivern](http://github.com/clivern).
