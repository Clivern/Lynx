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
  Get Environment by UUID and Project UUID
  """
  def get_environment_by_uuid(project_uuid, environment_uuid) do
    case ProjectContext.get_project_by_uuid(project_uuid) do
      nil ->
        {:not_found, "Project with UUID #{project_uuid} not found"}

      project ->
        case EnvironmentContext.get_env_by_uuid_project(project.id, environment_uuid) do
          nil ->
            {:not_found, "Environment with UUID #{environment_uuid} not found"}

          env ->
            {:ok, env}
        end
    end
  end

  def get_project_environments(project_uuid, offset, limit) do
    case ProjectContext.get_project_by_uuid(project_uuid) do
      nil ->
        {:not_found, "Project with UUID #{project_uuid} not found"}

      project ->
        {:ok, EnvironmentContext.get_project_envs(project.id, offset, limit)}
    end
  end

  def count_project_environments(project_uuid, offset, limit) do
    case ProjectContext.get_project_by_uuid(project_uuid) do
      nil ->
        {:not_found, "Project with UUID #{project_uuid} not found"}

      project ->
        {:ok, EnvironmentContext.count_project_envs(project.id)}
    end
  end

  def create_environment(data) do
  end

  def update_environment(data) do
  end

  @doc """
  Delete Environment by UUID and Project UUID
  """
  def delete_environment_by_uuid(project_uuid, environment_uuid) do
    case ProjectContext.get_project_by_uuid(project_uuid) do
      nil ->
        {:not_found, "Project with UUID #{project_uuid} not found"}

      project ->
        case EnvironmentContext.get_env_by_uuid_project(project.id, environment_uuid) do
          nil ->
            {:not_found, "Environment with UUID #{environment_uuid} not found"}

          env ->
            EnvironmentContext.delete_env(env)
            {:ok, "Environment with UUID #{environment_uuid} delete successfully"}
        end
    end
  end

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
