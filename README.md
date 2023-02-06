<p align="center">
    <img alt="Bandit Logo" src="/assets/img/logo.png?v=0.4.0" width="250" />
    <h3 align="center">Bandit</h3>
    <p align="center">A Fast, Secure and Reliable Terraform Backend, Set up in Minutes.</p>
    <p align="center">
        <a href="https://github.com/Clivern/Bandit/actions/workflows/ci.yml">
            <img src="https://github.com/Clivern/Bandit/actions/workflows/server_ci.yml/badge.svg"/>
        </a>
        <a href="https://github.com/Clivern/Bandit/releases">
            <img src="https://img.shields.io/badge/Version-0.4.0-1abc9c.svg">
        </a>
        <a href="https://github.com/Clivern/Bandit/blob/master/LICENSE">
            <img src="https://img.shields.io/badge/LICENSE-MIT-orange.svg">
        </a>
    </p>
</p>


### Deployment

To run with docker and docker-compose

```zsh
$ docker-compose up -d
```

To run on linux server

```zsh

```


### Development

To run `postgresql` with `docker` or `podman`

```zsh
$ docker run -itd \
    -e POSTGRES_USER=bandit \
    -e POSTGRES_PASSWORD=bandit \
    -e POSTGRES_DB=bandit_dev \
    -p 5432:5432 \
    --name postgresql \
    postgres:15.2

$ podman run -itd \
    -e POSTGRES_USER=bandit \
    -e POSTGRES_PASSWORD=bandit \
    -e POSTGRES_DB=bandit_dev \
    -p 5432:5432 \
    --name postgresql \
    postgres:15.2

# https://github.com/dbcli/pgcli
$ psql -h 127.0.0.1 -U bandit -d bandit_dev -W
```

Then run `bandit` with the following commands

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


### Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, `Bandit` is maintained under the [Semantic Versioning guidelines](https://semver.org/) and release process is predictable and business-friendly.

See the [Releases section of our GitHub project](https://github.com/clivern/bandit/releases) for changelogs for each release version of `Bandit`. It contains summaries of the most noteworthy changes made in each release. Also see the [Milestones section](https://github.com/clivern/bandit/milestones) for the future roadmap.


### Bug tracker

If you have any suggestions, bug reports, or annoyances please report them to our issue tracker at https://github.com/clivern/bandit/issues


### Security Issues

If you discover a security vulnerability within `Bandit`, please send an email to [hello@clivern.com](mailto:hello@clivern.com)


### Contributing

We are an open source, community-driven project so please feel free to join us. see the [contributing guidelines](CONTRIBUTING.md) for more details.


### License

© 2022, Clivern. Released under [MIT License](https://opensource.org/licenses/mit-license.php).

**Bandit** is authored and maintained by [@clivern](http://github.com/clivern).
