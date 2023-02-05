# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Module.ProjectModule do
  @moduledoc """
  Project Module
  """

  alias Bandit.Context.ProjectContext
  alias Bandit.Service.ValidatorService
  alias Bandit.Module.TeamModule

  @doc """
  Get Project by ID
  """
  def get_project_by_id(id) do
    case ProjectContext.get_project_by_id(id) do
      nil ->
        {:not_found, "Project with ID #{id} not found"}

      project ->
        {:ok, project}
    end
  end

  @doc """
  Get Project by UUID
  """
  def get_project_by_uuid(uuid) do
    case ProjectContext.get_project_by_uuid(uuid) do
      nil ->
        {:not_found, "Project with UUID #{uuid} not found"}

      project ->
        {:ok, project}
    end
  end

  @doc """
  Get projects
  """
  def get_projects(offset, limit) do
    ProjectContext.get_projects(offset, limit)
  end

  @doc """
  Count projects
  """
  def count_projects() do
    ProjectContext.count_projects()
  end

  @doc """
  Get user projects
  """
  def get_projects(user_id, offset, limit) do
    user_teams = TeamModule.get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    ProjectContext.get_projects_by_teams(teams_ids, offset, limit)
  end

  @doc """
  Count user projects
  """
  def count_projects(user_id) do
    user_teams = TeamModule.get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    ProjectContext.count_projects_by_teams(teams_ids)
  end

  @doc """
  Update Project
  """
  def update_project(data \\ %{}) do
    uuid = ValidatorService.get_str(data[:uuid], "")

    case get_project_by_uuid(uuid) do
      nil ->
        {:not_found, "Project with ID #{uuid} not found"}

      project ->
        new_project =
          ProjectContext.new_project(%{
            name: ValidatorService.get_str(data[:name], project.name),
            description: ValidatorService.get_str(data[:description], project.description),
            team_id: ValidatorService.get_int(data[:team_id], project.team_id),
            slug: project.slug
          })

        case ProjectContext.update_project(project, new_project) do
          {:ok, project} ->
            {:ok, project}

          {:error, changeset} ->
            messages =
              changeset.errors()
              |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

            {:error, Enum.at(messages, 0)}
        end
    end
  end

  @doc """
  Create Project
  """
  def create_project(data \\ %{}) do
    project =
      ProjectContext.new_project(%{
        name: data[:name],
        description: data[:description],
        slug: data[:slug],
        team_id: data[:team_id]
      })

    case ProjectContext.create_project(project) do
      {:ok, project} ->
        {:ok, project}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

  @doc """
  Delete Project By UUID
  """
  def delete_project_by_uuid(uuid) do
    case ProjectContext.get_project_by_uuid(uuid) do
      nil ->
        {:not_found, "Project with UUID #{uuid} not found"}

      project ->
        ProjectContext.delete_project(project)
        {:ok, "Project with UUID #{uuid} deleted successfully"}
    end
  end

  @doc """
  Count Team Projects
  """
  def count_projects_by_team(team_id) do
    ProjectContext.count_projects_by_team(team_id)
  end

  @doc """
  Check if a slug used with a team
  """
  def is_slug_used_in_team(slug, team_id) do
    case ProjectContext.get_project_by_slug_team_id(slug, team_id) do
      nil ->
        false

      _ ->
        true
    end
  end
end
