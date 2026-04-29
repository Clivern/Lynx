# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.MixProject do
  use Mix.Project

  @version "0.13.0"

  def get_version, do: @version

  def project do
    [
      app: :lynx,
      version: @version,
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [] ++ Mix.compilers(),
      listeners: [Phoenix.CodeReloader],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Lynx.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.8.5"},
      {:phoenix_ecto, "~> 4.7"},
      {:ecto_sql, "~> 3.13"},
      {:postgrex, "~> 0.22.0"},
      {:phoenix_html, "~> 4.3"},
      {:phoenix_html_helpers, "~> 1.0"},
      {:phoenix_view, "~> 2.0"},
      {:phoenix_live_reload, "~> 1.6", only: :dev},
      {:phoenix_live_view, "~> 1.1"},
      {:floki, "~> 0.38.1", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.7"},
      {:esbuild, "~> 0.10", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.25"},
      {:telemetry_metrics, "~> 1.1"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 1.0"},
      {:jason, "~> 1.4"},
      {:plug_cowboy, "~> 2.8"},
      {:bcrypt_elixir, "~> 3.3"},
      {:sleeplocks, "~> 1.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
      # "assets.deploy": ["esbuild default --minify", "phx.digest"]
    ]
  end
end

defmodule Mix.Tasks.Version do
  use Mix.Task

  def run(_) do
    Mix.shell().info("Currnt Version: v#{Lynx.MixProject.get_version()}")
  end
end
