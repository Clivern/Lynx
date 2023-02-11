# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Context.StateContext do
  @moduledoc """
  State Context Module
  """

  import Ecto.Query

  alias Lynx.Repo
  alias Lynx.Model.{StateMeta, State}

  @doc """
  Get a new state
  """
  def new_state(attrs \\ %{}) do
    %{
      name: attrs.name,
      value: attrs.value,
      environment_id: attrs.environment_id,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Get a state meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      state_id: meta.state_id
    }
  end

  @doc """
  Create a new state
  """
  def create_state(attrs \\ %{}) do
    %State{}
    |> State.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a state by ID
  """
  def get_state_by_id(id) do
    Repo.get(State, id)
  end

  @doc """
  Get state by UUID
  """
  def get_state_by_uuid(uuid) do
    from(
      s in State,
      where: s.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Get state by name
  """
  def get_state_by_name(name) do
    from(
      s in State,
      where: s.name == ^name
    )
    |> Repo.one()
  end

  @doc """
  Get latest state by environment id
  """
  def get_latest_state_by_environment_id(environment_id) do
    from(
      s in State,
      where: s.environment_id == ^environment_id
    )
    |> last(:inserted_at)
    |> Repo.one()
  end

  @doc """
  Count environment states
  """
  def count_states(environment_id) do
    from(s in State,
      select: count(s.id),
      where: s.environment_id == ^environment_id
    )
    |> Repo.one()
  end

  @doc """
  Update a state
  """
  def update_state(state, attrs) do
    state
    |> State.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a state
  """
  def delete_state(state) do
    Repo.delete(state)
  end

  @doc """
  Retrieve all states
  """
  def get_states() do
    Repo.all(State)
  end

  @doc """
  Retrieve states
  """
  def get_states(offset, limit) do
    from(s in State,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Create a new state meta attribute
  """
  def create_state_meta(attrs \\ %{}) do
    %StateMeta{}
    |> StateMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a state meta by id
  """
  def get_state_meta_by_id(id) do
    Repo.get(StateMeta, id)
  end

  @doc """
  Update a state meta
  """
  def update_state_meta(state_meta, attrs) do
    state_meta
    |> StateMeta.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a state meta
  """
  def delete_state_meta(state_meta) do
    state_meta
    |> Repo.delete()
  end

  @doc """
  Get state meta by state id and key
  """
  def get_state_meta_by_id_key(state_id, meta_key) do
    from(
      s in StateMeta,
      where: s.state_id == ^state_id,
      where: s.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get state metas
  """
  def get_state_metas(state_id) do
    from(
      s in StateMeta,
      where: s.state_id == ^state_id
    )
    |> Repo.all()
  end
end
