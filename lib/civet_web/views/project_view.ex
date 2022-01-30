# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.ProjectView do
  use CivetWeb, :view

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
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format project
  defp render_project(project) do
    %{
      id: project.id,
      name: project.name,
      description: project.description,
      environment: project.environment,
      username: project.username,
      secret: project.secret,
      createdAt: project.inserted_at,
      updatedAt: project.updated_at
    }
  end
end
