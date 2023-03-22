# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Context.LockContext do
  @moduledoc """
  Lock Context Module
  """

  import Ecto.Query

  alias Lynx.Repo
  alias Lynx.Model.{LockMeta, Lock}

  @doc """
  Get a new lock
  """
  def new_lock(attrs \\ %{}) do
    %{
      environment_id: attrs.environment_id,
      operation: attrs.operation,
      info: attrs.info,
      who: attrs.who,
      version: attrs.version,
      path: attrs.path,
      is_active: attrs.is_active,
      uuid: Map.get(attrs, :uuid, Ecto.UUID.generate())
    }
  end

  @doc """
  Create a lock meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      lock_id: meta.lock_id
    }
  end

  @doc """
  Create a new lock
  """
  def create_lock(attrs \\ %{}) do
    %Lock{}
    |> Lock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get a lock by id
  """
  def get_lock_by_id(id) do
    Repo.get(Lock, id)
  end

  @doc """
  Get a lock by uuid
  """
  def get_lock_by_uuid(uuid) do
    from(
      l in Lock,
      where: l.uuid == ^uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Get active lock by environment id
  """
  def get_active_lock_by_environment_id(environment_id) do
    from(
      l in Lock,
      where: l.environment_id == ^environment_id,
      where: l.is_active == true
    )
    |> lock("FOR UPDATE")
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Check if environment is locked
  """
  def is_environment_locked(environment_id) do
    env =
      from(
        l in Lock,
        where: l.environment_id == ^environment_id,
        where: l.is_active == true
      )
      |> limit(1)
      |> Repo.one()

    case env do
      nil ->
        false

      _ ->
        true
    end
  end

  @doc """
  Update a lock
  """
  def update_lock(lock, attrs) do
    lock
    |> Lock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a lock
  """
  def delete_lock(lock) do
    Repo.delete(lock)
  end

  @doc """
  Retrieve all locks
  """
  def get_locks() do
    Repo.all(Lock)
  end

  @doc """
  Create a new lock meta
  """
  def create_lock_meta(attrs \\ %{}) do
    %LockMeta{}
    |> LockMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get lock meta by id
  """
  def get_lock_meta_by_id(id) do
    Repo.get(LockMeta, id)
  end

  @doc """
  Update lock meta
  """
  def update_lock_meta(lock_meta, attrs) do
    lock_meta
    |> LockMeta.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete lock meta
  """
  def delete_lock_meta(lock_meta) do
    lock_meta
    |> Repo.delete()
  end

  @doc """
  Get lock meta by id and key
  """
  def get_lock_meta_by_id_key(lock_id, meta_key) do
    from(
      l in LockMeta,
      where: l.lock_id == ^lock_id,
      where: l.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get lock metas
  """
  def get_lock_metas(lock_id) do
    from(
      l in LockMeta,
      where: l.lock_id == ^lock_id
    )
    |> Repo.all()
  end
end
