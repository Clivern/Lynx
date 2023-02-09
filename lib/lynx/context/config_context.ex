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
  Retrieves a new configuration with the provided attributes.

  ## Parameters:
    - attrs (map): A map containing configuration attributes like name, value.

  ## Returns:
    - Map: A new configuration map with name, value, and a generated UUID.
  """
  def new_config(attrs \\ %{}) do
    %{
      name: attrs.name,
      value: attrs.value,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Creates a new configuration record in the database.

  ## Parameters:
    - attrs (map): A map containing configuration attributes like name, value.

  ## Returns:
    - Config: The newly created configuration record.
  """
  def create_config(attrs \\ %{}) do
    %Config{}
    |> Config.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieves a configuration record by its ID.

  ## Parameters:
    - id (integer): The ID of the configuration record.

  ## Returns:
    - Config: The configuration record with the specified ID.
  """
  def get_config_by_id(id) do
    Repo.get(Config, id)
  end

  @doc """
  Retrieves a configuration record by its UUID.

  ## Parameters:
    - uuid (string): The UUID of the configuration record.

  ## Returns:
    - Config: The configuration record with the specified UUID.
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
  Retrieves a configuration record by its name.

  ## Parameters:
    - name (string): The name of the configuration record.

  ## Returns:
    - Config: The configuration record with the specified name.
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
  Updates an existing configuration record with new attributes.

  ## Parameters:
    - config (Config): The existing configuration record to update.
    - attrs (map): A map containing new attributes to update in the configuration record.

  ## Returns:
    - Config: The updated configuration record.
  """
  def update_config(config, attrs) do
    config
    |> Config.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an existing configuration record from the database.

  ## Parameters:
    - config (Config): The existing configuration record to delete.

  ## Returns:
    - :ok if successful, otherwise an error message.
  """
  def delete_config(config) do
    Repo.delete(config)
  end
end
