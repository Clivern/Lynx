# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.ProjectView do
  use LynxWeb, :view

  alias Lynx.Module.EnvironmentModule
  alias Lynx.Module.TeamModule

  # Render projects list
  def render("list.json", %{projects: projects, metadata: metadata}) do
    %{
      projects: Enum.map(projects, &render_project/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render project
  def render("index.json", %{project: project}) do
    render_project(project)
  end

  # Render errors
  def render("error.json", %{message: message}) do
    %{errorMessage: message}
  end

  # Format project
  defp render_project(project) do
    {_, team} = TeamModule.get_team_by_id(project.team_id)

    %{
      id: project.uuid,
      name: project.name,
      slug: project.slug,
      description: project.description,
      team: %{
        id: team.uuid,
        name: team.name,
        slug: team.slug
      },
      envCount: EnvironmentModule.count_project_envs(project.id),
      createdAt: project.inserted_at,
      updatedAt: project.updated_at
    }
  end
end
