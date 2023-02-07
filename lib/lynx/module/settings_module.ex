# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.SettingsModule do
  @moduledoc """
  Settings Module
  """

  alias Lynx.Context.ConfigContext

  @doc """
  Update Application Configs
  """
  def update_configs(configs \\ %{}) do
    items = [
      ConfigContext.new_config(%{name: "app_name", value: configs[:app_name]}),
      ConfigContext.new_config(%{name: "app_url", value: configs[:app_url]}),
      ConfigContext.new_config(%{name: "app_email", value: configs[:app_email]})
    ]

    for item <- items do
      config = ConfigContext.get_config_by_name(item.name)

      case ConfigContext.update_config(config, %{value: item.value}) do
        {:ok, _} ->
          {:success, nil}

        {:error, changeset} ->
          messages =
            changeset.errors()
            |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

          {:error, Enum.at(messages, 0)}
      end
    end
  end

  @doc """
  Get Config
  """
  def get_config(name, default \\ "") do
    case ConfigContext.get_config_by_name(name) do
      nil ->
        default

      config ->
        config.value
    end
  end
end
