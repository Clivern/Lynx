# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/raccoon start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if System.get_env("PHX_SERVER") do
  config :raccoon, RaccoonWeb.Endpoint, server: true
end

if config_env() == :prod do
  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  if System.get_env("DB_SSL") || "off" == "on" do
    config :raccoon, Raccoon.Repo,
      username: System.get_env("DB_USERNAME"),
      password: System.get_env("DB_PASSWORD"),
      hostname: System.get_env("DB_HOSTNAME"),
      database: System.get_env("DB_DATABASE"),
      port: String.to_integer(System.get_env("DB_PORT")),
      maintenance_database: System.get_env("DB_DATABASE"),
      pool_size: String.to_integer(System.get_env("DB_POOL_SIZE") || "10"),
      socket_options: maybe_ipv6,
      ssl: true,
      ssl_opts: [
        verify: :verify_peer,
        cacertfile: System.get_env("DB_CA_CERTFILE_PATH") || ""
      ]
  else
    config :raccoon, Raccoon.Repo,
      username: System.get_env("DB_USERNAME"),
      password: System.get_env("DB_PASSWORD"),
      hostname: System.get_env("DB_HOSTNAME"),
      database: System.get_env("DB_DATABASE"),
      port: String.to_integer(System.get_env("DB_PORT")),
      maintenance_database: System.get_env("DB_DATABASE"),
      pool_size: String.to_integer(System.get_env("DB_POOL_SIZE") || "10"),
      socket_options: maybe_ipv6
  end

  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("APP_SECRET") ||
      raise """
      environment variable APP_SECRET is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("APP_HOST") || "example.com"
  port = String.to_integer(System.get_env("APP_PORT") || "4000")

  config :raccoon, RaccoonWeb.Endpoint,
    url: [host: host, port: port, scheme: System.get_env("APP_HTTP_SCHEMA") || "http"],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :raccoon, Raccoon.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end
