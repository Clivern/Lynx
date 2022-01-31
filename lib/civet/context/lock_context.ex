# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.LockContext do
  @moduledoc """
  Lock Context Module
  """

  import Ecto.Query
  alias Civet.Repo
  alias Civet.Model.{LockMeta, Lock}

  @doc """
  Get a new lock
  """
  def new_lock(lock \\ %{}) do
    %{
      project_id: message.project_id,
      uuid: Ecto.UUID.generate()
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
      u in Lock,
      where: u.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Get a lock by project id
  """
  def get_lock_by_project_id(project_id) do
    from(
      u in Lock,
      where: u.project_id == ^project_id
    )
    |> Repo.one()
  end

  @doc """
  Delete a lock
  """
  def delete_lock(lock) do
    Repo.delete(lock)
  end

  @doc """
  Retrieve all messages
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
    LockMeta.changeset(lock_meta, attrs)
    |> Repo.update()
  end

  @doc """
  Delete lock meta
  """
  def delete_lock_meta(lock_meta) do
    Repo.delete(lock_meta)
  end

  @doc """
  Get lock meta by id and key
  """
  def get_lock_meta_by_key(lock_id, meta_key) do
    from(
      u in LockMeta,
      where: u.lock_id == ^lock_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get lock metas
  """
  def get_lock_metas(lock_id) do
    from(
      u in LockMeta,
      where: u.lock_id == ^lock_id
    )
    |> Repo.all()
  end
end
