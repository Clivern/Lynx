# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Lynx.Repo,
      # Start the Telemetry supervisor
      LynxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lynx.PubSub},
      # Start the Endpoint (http/https)
      LynxWeb.Endpoint
      # Start a worker by calling: Lynx.Worker.start_link(arg)
      # {Lynx.Workers, %{}}
    ]

    children =
      if (System.get_env("EXPOSE_PROMETHEUS_METRICS") || "false") == "true" do
        children ++ [Lynx.PromEx]
      else
        children
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lynx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LynxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
