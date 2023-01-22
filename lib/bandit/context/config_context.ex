# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Context.ConfigContext do
  @moduledoc """
  Config Context Module
  """

  import Ecto.Query

  alias Bandit.Repo
  alias Bandit.Model.Config

  @doc """
  Get a new config
  """
  def new_config(attrs \\ %{}) do
    %{
      name: attrs.name,
      value: attrs.value,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Create a new config
  """
  def create_config(attrs \\ %{}) do
    %Config{}
    |> Config.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get a config by id
  """
  def get_config_by_id(id) do
    Repo.get(Config, id)
  end

  @doc """
  Get a config by uuid
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
  Get a config by name
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
  Update a config
  """
  def update_config(config, attrs) do
    config
    |> Config.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a config
  """
  def delete_config(config) do
    Repo.delete(config)
  end
end
