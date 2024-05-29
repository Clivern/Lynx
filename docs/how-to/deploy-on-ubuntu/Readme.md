### Ubuntu Deployment

1. Install elixir and `PostgreSQL`

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

2. Setup `PostgreSQL` database, username and password

```zsh
# Create PostgreSQL user with password
$ sudo -u postgres psql -c "CREATE USER lynx WITH PASSWORD 'lynx';"
$ sudo -u postgres psql -c "ALTER USER lynx CREATEDB;"

# Create database
$ sudo -u postgres psql -c "CREATE DATABASE lynx_dev OWNER lynx;"
```

3. Configure Environment Variables: Set up the required environment variables from `.env.example`.

```zsh
$ mkdir -p /etc/lynx
$ cd /etc/lynx
$ git clone https://github.com/Clivern/Lynx.git app
$ cd /etc/lynx/app
$ cp .env.example .env.local # Adjust the database configs
```

4. Migrate the database

```zsh
$ make deps
$ make migrate
```

5. Create a systemd service file `/etc/systemd/system/lynx.service`

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
