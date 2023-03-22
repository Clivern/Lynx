# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Context.ConfigContext do
  @moduledoc """
  Config Context Module
  """

  import Ecto.Query

  alias Lynx.Repo
  alias Lynx.Model.Config

  @doc """
  Retrieves a new configuration with the provided attributes
  """
  def new_config(attrs \\ %{}) do
    %{
      name: attrs.name,
      value: attrs.value,
      uuid: Map.get(attrs, :uuid, Ecto.UUID.generate())
    }
  end

  @doc """
  Creates a new configuration record
  """
  def create_config(attrs \\ %{}) do
    %Config{}
    |> Config.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieves a configuration record by its ID
  """
  def get_config_by_id(id) do
    Repo.get(Config, id)
  end

  @doc """
  Retrieves a configuration record by its UUID
  """
  def get_config_by_uuid(uuid) do
    from(
      c in Config,
      where: c.uuid == ^uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Retrieves a configuration record by its name
  """
  def get_config_by_name(name) do
    from(
      c in Config,
      where: c.name == ^name
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Updates an existing configuration record
  """
  def update_config(config, attrs) do
    config
    |> Config.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an existing configuration record
  """
  def delete_config(config) do
    Repo.delete(config)
  end
end
