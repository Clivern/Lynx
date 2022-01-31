# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Pard.Repo,
      # Start the Telemetry supervisor
      PardWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pard.PubSub},
      # Start the Endpoint (http/https)
      PardWeb.Endpoint
      # Start a worker by calling: Pard.Worker.start_link(arg)
      # {Pard.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
