# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bandit.Repo,
      # Start the Telemetry supervisor
      BanditWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bandit.PubSub},
      # Start the Endpoint (http/https)
      BanditWeb.Endpoint
      # Start a worker by calling: Bandit.Worker.start_link(arg)
      # {Bandit.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bandit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BanditWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
