# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Context.SnapshotContext do
  @moduledoc """
  Snapshot Context Module
  """

  import Ecto.Query

  alias Lynx.Repo
  alias Lynx.Model.{Snapshot, SnapshotMeta}

  @doc """
  Get a new snapshot
  """
  def new_snapshot(snapshot \\ %{}) do
    %{
      title: snapshot.title,
      description: snapshot.description,
      record_type: snapshot.record_type,
      record_uuid: snapshot.record_uuid,
      status: snapshot.status,
      data: snapshot.data,
      team_id: snapshot.team_id,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Get a snapshot meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      snapshot_id: meta.snapshot_id
    }
  end

  @doc """
  Create a new snapshot
  """
  def create_snapshot(attrs \\ %{}) do
    %Snapshot{}
    |> Snapshot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a snapshot by ID
  """
  def get_snapshot_by_id(id) do
    Repo.get(Snapshot, id)
  end

  @doc """
  Get snapshot by uuid
  """
  def get_snapshot_by_uuid(uuid) do
    from(
      t in Snapshot,
      where: t.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Update a snapshot
  """
  def update_snapshot(snapshot, attrs) do
    snapshot
    |> Snapshot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a snapshot
  """
  def delete_snapshot(snapshot) do
    Repo.delete(snapshot)
  end

  @doc """
  Retrieve all tasks
  """
  def get_snapshots() do
    Repo.all(Snapshot)
  end

  @doc """
  Retrieve snapshots
  """
  def get_snapshots(offset, limit) do
    from(t in Snapshot,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Create a new snapshot meta
  """
  def create_snapshot_meta(attrs \\ %{}) do
    %SnapshotMeta{}
    |> SnapshotMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a snapshot meta by id
  """
  def get_snapshot_meta_by_id(id) do
    Repo.get(SnapshotMeta, id)
  end

  @doc """
  Update a snapshot meta
  """
  def update_snapshot_meta(snapshot_meta, attrs) do
    snapshot_meta
    |> SnapshotMeta.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a snapshot meta
  """
  def delete_snapshot_meta(snapshot_meta) do
    Repo.delete(snapshot_meta)
  end

  @doc """
  Get snapshot meta by snapshot id and key
  """
  def get_snapshot_meta_by_id_key(snapshot_id, meta_key) do
    from(
      e in SnapshotMeta,
      where: e.snapshot_id == ^snapshot_id,
      where: e.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get snapshot metas
  """
  def get_snapshot_metas(snapshot_id) do
    from(
      e in SnapshotMeta,
      where: e.snapshot_id == ^snapshot_id
    )
    |> Repo.all()
  end
end
