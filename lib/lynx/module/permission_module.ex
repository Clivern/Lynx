# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.PermissionModule do
  @moduledoc """
  Permission Module
  """

  alias Lynx.Context.ProjectContext
  alias Lynx.Module.TeamModule

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

  def can_access_project_uuid(:project, :regular, uuid, user_id) do
    case ProjectContext.get_project_by_uuid_teams(uuid, get_user_teams_ids(user_id)) do
      nil ->
        false

      _ ->
        true
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
