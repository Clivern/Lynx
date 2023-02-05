# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Module.EnvironmentModule do
  @moduledoc """
  Environment Module
  """

  alias Bandit.Context.TeamContext
  alias Bandit.Context.ProjectContext
  alias Bandit.Context.EnvironmentContext

  @doc """
  Validate Auth Data
  """
  def is_access_allowed(data \\ %{}) do
    case TeamContext.get_team_by_slug(data[:team_slug]) do
      nil ->
        {:error, "Invalid team slug"}

      team ->
        case ProjectContext.get_project_by_slug_team_id(data[:project_slug], team.id) do
          nil ->
            {:error, "Invalid project slug"}

          project ->
            case EnvironmentContext.get_env_by_slug_credentials(
                   data[:env_slug],
                   project.id,
                   data[:username],
                   data[:secret]
                 ) do
              nil ->
                {:error, "Invalid environment credentials"}

              env ->
                {:ok, team, project, env}
            end
        end
    end
  end
end
