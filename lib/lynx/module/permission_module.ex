# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.PermissionModule do
  @moduledoc """
  Permission Module
  """

  alias Lynx.Context.ProjectContext
  alias Lynx.Context.SnapshotContext
  alias Lynx.Context.EnvironmentContext
  alias Lynx.Module.TeamModule

  def can_access_project_id(:project, :anonymous, _id, _user_id) do
    false
  end

  def can_access_project_id(:project, :super, _id, _user_id) do
    true
  end

  def can_access_project_id(:project, :regular, id, user_id) do
    case ProjectContext.get_project_by_id_teams(id, get_user_teams_ids(user_id)) do
      nil ->
        false

      _ ->
        true
    end
  end

  def can_access_project_uuid(:project, :super, _uuid, _user_id) do
    true
  end

  def can_access_project_uuid(:project, :anonymous, _uuid, _user_id) do
    false
  end

  def can_access_project_uuid(:project, :regular, uuid, user_id) do
    case ProjectContext.get_project_by_uuid_teams(uuid, get_user_teams_ids(user_id)) do
      nil ->
        false

      _ ->
        true
    end
  end

  def can_access_snapshot_id(:snapshot, :anonymous, _id, _user_id) do
    false
  end

  def can_access_snapshot_id(:snapshot, :super, _id, _user_id) do
    true
  end

  def can_access_snapshot_id(:snapshot, :regular, id, user_id) do
    case SnapshotContext.get_snapshot_by_id_teams(id, get_user_teams_ids(user_id)) do
      nil ->
        false

      _ ->
        true
    end
  end

  def can_access_snapshot_uuid(:snapshot, :anonymous, _id, _user_id) do
    false
  end

  def can_access_snapshot_uuid(:snapshot, :super, _id, _user_id) do
    true
  end

  def can_access_snapshot_uuid(:snapshot, :regular, uuid, user_id) do
    case SnapshotContext.get_snapshot_by_uuid_teams(uuid, get_user_teams_ids(user_id)) do
      nil ->
        false

      _ ->
        true
    end
  end

  def can_access_environment_uuid(:environment, :super, _uuid, _user_id) do
    true
  end

  def can_access_environment_uuid(:environment, :anonymous, _uuid, _user_id) do
    false
  end

  def can_access_environment_uuid(:environment, :regular, uuid, user_id) do
    case EnvironmentContext.get_env_by_uuid(uuid) do
      nil ->
        false

      env ->
        case ProjectContext.get_project_by_id_teams(env.project_id, get_user_teams_ids(user_id)) do
          nil ->
            false

          _ ->
            true
        end
    end
  end

  defp get_user_teams_ids(user_id) do
    user_teams = TeamModule.get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    teams_ids
  end
end
