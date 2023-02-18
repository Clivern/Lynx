# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.SnapshotModule do
  @moduledoc """
  Snapshot Module
  """

  alias Lynx.Context.SnapshotContext
  alias Lynx.Module.TeamModule

  @doc """
  Get Snapshot by UUID
  """
  def get_snapshot_by_uuid(uuid) do
    case SnapshotContext.get_snapshot_by_uuid(uuid) do
      nil ->
        {:not_found, "Snapshot with UUID #{uuid} not found"}

      snapshot ->
        {:ok, snapshot}
    end
  end

  @doc """
  Create A Snapshot
  """
  def create_snapshot(data \\ %{}) do
    snapshot =
      SnapshotContext.new_snapshot(%{
        title: data[:title],
        description: data[:description],
        record_type: data[:record_type],
        record_uuid: data[:record_uuid],
        status: data[:status],
        data: data[:data],
        team_id: data[:team_id]
      })

    case SnapshotContext.create_snapshot(snapshot) do
      {:ok, snapshot} ->
        {:ok, snapshot}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

  @doc """
  Get User Snapshots
  """
  def get_snapshots(user_id, offset, limit) do
    user_teams = TeamModule.get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    SnapshotContext.get_snapshots_by_teams(teams_ids, offset, limit)
  end

  @doc """
  Get Snapshots
  """
  def get_snapshots(offset, limit) do
    SnapshotContext.get_snapshots(offset, limit)
  end

  @doc """
  Count Snapshots
  """
  def count_snapshots() do
    SnapshotContext.count_snapshots()
  end

  @doc """
  Count User Snapshots
  """
  def count_snapshots(user_id) do
    user_teams = TeamModule.get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    SnapshotContext.count_snapshots_by_teams(teams_ids)
  end

  @doc """
  Take Snapshot
  """
  def take_snapshot(_uuid) do
  end

  @doc """
  Restore Snapshot
  """
  def restore_snapshot(_uuid) do
  end

  @doc """
  Delete Snapshot by UUID
  """
  def delete_snapshot_by_uuid(uuid) do
    case get_snapshot_by_uuid(uuid) do
      {:not_found, msg} ->
        {:not_found, msg}

      {:ok, snapshot} ->
        SnapshotContext.delete_snapshot(snapshot)
        {:ok, "Snapshot with ID #{uuid} deleted successfully"}
    end
  end
end
