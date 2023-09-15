<p align="center">
    <img alt="Lynx Logo" src="/assets/img/logo.png?v=0.11.0" width="180" />
    <h3 align="center">Lynx</h3>
    <p align="center">A Fast, Secure and Reliable Terraform Backend, Set up in Minutes.</p>
    <p align="center">
        <a href="https://github.com/Clivern/Lynx/actions/workflows/ci.yml">
            <img src="https://github.com/Clivern/Lynx/actions/workflows/server_ci.yml/badge.svg"/>
        </a>
        <a href="https://github.com/Clivern/Lynx/releases">
            <img src="https://img.shields.io/badge/Version-0.11.0-1abc9c.svg">
        </a>
        <a href="https://hub.docker.com/r/clivern/lynx/tags">
            <img src="https://img.shields.io/badge/Docker-0.11.0-1abc9c.svg">
        </a>
        <a href="https://github.com/Clivern/terraform-provider-lynx">
            <img src="https://img.shields.io/badge/Terraform-Provider-yellow.svg">
        </a>
        <a href="https://github.com/Clivern/Lynx/blob/master/LICENSE">
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


### Docker Deployment

1. To run with docker and docker-compose. Make sure you update `server_name` in `nginx.conf` file.

```zsh
$ git clone https://github.com/Clivern/Lynx.git app
$ cd app
$ docker-compose up -d
```

Here is a [video demonstration](https://www.youtube.com/watch?v=YNkHfysr3-0)


### Ubuntu Deployment

1. Install Elixir: You can install Elixir on Ubuntu using the following commands:

```zsh
$ sudo apt-get update
$ sudo apt-get install elixir
```

2. Install PostgreSQL: Install PostgreSQL on Ubuntu with:

```zsh
$ sudo apt-get install postgresql postgresql-contrib
```

3. Configure Environment Variables: Set up the required environment variables from `.env.example`.

```zsh
$ mkdir -p /etc/lynx
$ cd /etc/lynx
$ git clone https://github.com/Clivern/Lynx.git app
$ cp app/.env.example .env.local # Adjust the database configs
```

4. Migrate the database

```zsh
$ cd /etc/lynx/app
$ make migrate
```

5. Create a Systemd Service File.

```zsh
[Unit]
Description=Lynx

[Service]
Type=simple
EnvironmentFile=/etc/lynx/app/.env.local
ExecStart=/usr/bin/mix phx.server

[Install]
WantedBy=multi-user.target
```

```zsh
sudo systemctl enable lynx.service
sudo systemctl start lynx.service
```


### Development

To run `postgresql` with `docker` or `podman`

```zsh
$ docker run -itd \
    -e POSTGRES_USER=lynx \
    -e POSTGRES_PASSWORD=lynx \
    -e POSTGRES_DB=lynx_dev \
    -p 5432:5432 \
    --name lyx \
    postgres:15.2

$ podman run -itd \
    -e POSTGRES_USER=lynx \
    -e POSTGRES_PASSWORD=lynx \
    -e POSTGRES_DB=lynx_dev \
    -p 5432:5432 \
    --name lyx \
    postgres:15.2

# https://github.com/dbcli/pgcli
$ psql -h 127.0.0.1 -U lynx -d lynx_dev -W
```

Then run `lynx` with the following commands

```zsh
$ cp .env.example .env.local

$ export $(cat .env.local | xargs)
```

```
$ make deps

$ make migrate

$ make run

$ make test
```


### API Documentation

To explore the API documentation, copy the content of `api.yml` and paste in https://editor.swagger.io/.


### Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, `Lynx` is maintained under the [Semantic Versioning guidelines](https://semver.org/) and release process is predictable and business-friendly.

See the [Releases section of our GitHub project](https://github.com/clivern/lynx/releases) for changelogs for each release version of `Lynx`. It contains summaries of the most noteworthy changes made in each release. Also see the [Milestones section](https://github.com/clivern/lynx/milestones) for the future roadmap.


### Bug tracker

If you have any suggestions, bug reports, or annoyances please report them to our issue tracker at https://github.com/clivern/lynx/issues


### Security Issues

If you discover a security vulnerability within `Lynx`, please send an email to [hello@clivern.com](mailto:hello@clivern.com)


### Contributing

We are an open source, community-driven project so please feel free to join us. see the [contributing guidelines](CONTRIBUTING.md) for more details.


### License

© 2023, Clivern. Released under [MIT License](https://opensource.org/licenses/mit-license.php).

**Lynx** is authored and maintained by [@clivern](http://github.com/clivern).
