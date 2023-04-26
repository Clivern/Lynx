---
# Page settings
layout: documentation-single
title: Development
description: In this section you will learn how to change lynx codebase, run it locally and run test cases.
keywords: terraform-backend, lynx, terraform, clivern
comments: false
order: 5
hero:
    title: Development
    text: In this section you will learn how to change lynx codebase, run it locally and run test cases.
---

## Development

Lynx is built with phoenix framework. Like other phoenix frameworks, you need the following in order to run it locally:

- the Elixir programming language
- The Erlang VM - Elixir code compiles to Erlang byte code to run on the Erlang virtual machine. Without Erlang, Elixir code has no virtual machine to run on, so we need to install Erlang as well.
- Database - Phoenix recommends PostgreSQL, but you can pick others or not use a database at all and other optional packages.
- inotify-tools (for Linux users) - Phoenix provides a very handy feature called Live Reloading. As you change your views or your assets

Please take a look at this list and make sure to install anything necessary for your system. Having dependencies installed in advance can prevent frustrating problems later on.

You can install Elixir using instructions from [the Elixir Installation Page](https://elixir-lang.org/install.html), we will usually get Erlang too. If Erlang was not installed along with Elixir, please see the Erlang Instructions section of the [Elixir Installation Page](https://elixir-lang.org/install.html#installing-erlang) for instructions.

The PostgreSQL wiki has [installation guides](https://wiki.postgresql.org/wiki/Detailed_installation_guides) for a number of different systems. But also you can use `docker` or `podman` to run a PostgreSQL locally.

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

Then clone and run `lynx` with the following commands

```zsh
$ git clone git@github.com:Clivern/Lynx.git lynx
$ cd lynx
$ cp .env.example .env.local

$ export $(cat .env.local | xargs)
```

To install dependencies

```zsh
$ make deps
```

To migrate the database

```zsh
$ make migrate
```

To run lynx

```zsh
$ make run
```

To run test cases

```zsh
$ make test
```
