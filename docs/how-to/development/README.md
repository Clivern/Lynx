# Development

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

## API Documentation

To explore the API documentation, copy the content of `api.yml` and paste in https://editor.swagger.io/.
