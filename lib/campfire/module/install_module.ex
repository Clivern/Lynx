# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Campfire.Module.InstallModule do
  @moduledoc """
  Install Module
  """

  alias Campfire.Context.UserContext
  alias Campfire.Context.ConfigContext
  alias Campfire.Service.AuthService

  @doc """
  Check if app is installed
  """
  def is_installed() do
    config = ConfigContext.get_config_by_name("is_installed")

    case config do
      nil ->
        false

      _ ->
        true
    end
  end

  @doc """
  Get Application Key
  """
  def get_app_key() do
    AuthService.get_random_salt()
  end

  @doc """
  Store Application Configs
  """
  def store_configs(configs \\ %{}) do
    items = [
      ConfigContext.new_config(%{name: "is_installed", value: "yes"}),
      ConfigContext.new_config(%{name: "app_name", value: configs[:app_name]}),
      ConfigContext.new_config(%{name: "app_url", value: configs[:app_url]}),
      ConfigContext.new_config(%{name: "app_email", value: configs[:app_email]}),
      ConfigContext.new_config(%{name: "app_key", value: configs[:app_key]})
    ]

    for item <- items do
      case ConfigContext.create_config(item) do
        {:ok, _} ->
          :success

        {:error, changeset} ->
          messages =
            changeset.errors()
            |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

          {:error, Enum.at(messages, 0)}
      end
    end
  end

  @doc """
  Create Admin Account
  """
  def create_admin(data \\ %{}) do
    user =
      UserContext.new_user(%{
        email: data[:admin_email],
        name: data[:admin_name],
        password_hash: AuthService.hash_password(data[:admin_password], data[:app_key]),
        verified: false,
        last_seen: DateTime.utc_now(),
        role: "super",
        api_key: AuthService.get_uuid()
      })

    result = UserContext.create_user(user)

    case result do
      {:ok, _} ->
        :success

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end
end
