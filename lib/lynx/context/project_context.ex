# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Context.ProjectContext do
  @moduledoc """
  Project Context Module
  """

  import Ecto.Query

  alias Lynx.Repo
  alias Lynx.Model.{ProjectMeta, Project}

  @doc """
  Get a new project
  """
  def new_project(attrs \\ %{}) do
    %{
      name: attrs.name,
      description: attrs.description,
      slug: attrs.slug,
      team_id: attrs.team_id,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Get a project meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      project_id: meta.project_id
    }
  end

  @doc """
  Create a new project
  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get Project ID with UUID
  """
  def get_project_id_with_uuid(uuid) do
    case get_project_by_uuid(uuid) do
      nil ->
        nil

      project ->
        project.id
    end
  end

  @doc """
  Retrieve a project by ID
  """
  def get_project_by_id(id) do
    Repo.get(Project, id)
  end

  @doc """
  Get project by UUID
  """
  def get_project_by_uuid(uuid) do
    from(
      p in Project,
      where: p.uuid == ^uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Get project by slug and team
  """
  def get_project_by_slug_team_id(slug, team_id) do
    from(
      p in Project,
      where: p.slug == ^slug,
      where: p.team_id == ^team_id
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Update a project
  """
  def update_project(project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a project
  """
  def delete_project(project) do
    Repo.delete(project)
  end

  @doc """
  Retrieve all projects
  """
  def get_projects() do
    Repo.all(Project)
  end

  @doc """
  Get projects
  """
  def get_projects(offset, limit) do
    from(p in Project,
      order_by: [desc: p.inserted_at],
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Count projects
  """
  def count_projects() do
    from(p in Project,
      select: count(p.id)
    )
    |> Repo.one()
  end

  @doc """
  Get projects by teams
  """
  def get_projects_by_teams(teams_ids, offset, limit) do
    from(p in Project,
      order_by: [desc: p.inserted_at],
      where: p.team_id in ^teams_ids,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Count projects by teams
  """
  def count_projects_by_teams(teams_ids) do
    from(p in Project,
      select: count(p.id),
      where: p.team_id in ^teams_ids
    )
    |> Repo.one()
  end

  @doc """
  Get projects by team
  """
  def get_projects_by_team(team_id, offset, limit) do
    from(p in Project,
      order_by: [desc: p.inserted_at],
      where: p.team_id == ^team_id,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Count projects by team
  """
  def count_projects_by_team(team_id) do
    from(p in Project,
      select: count(p.id),
      where: p.team_id == ^team_id
    )
    |> Repo.one()
  end

  @doc """
  Create a new project meta attribute
  """
  def create_project_meta(attrs \\ %{}) do
    %ProjectMeta{}
    |> ProjectMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a project meta by id
  """
  def get_project_meta_by_id(id) do
    Repo.get(ProjectMeta, id)
  end

  @doc """
  Update a project meta
  """
  def update_project_meta(project_meta, attrs) do
    project_meta
    |> ProjectMeta.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a project meta
  """
  def delete_project_meta(project_meta) do
    project_meta
    |> Repo.delete()
  end

  @doc """
  Get project meta by project id and key
  """
  def get_project_meta_by_id_key(project_id, meta_key) do
    from(
      p in ProjectMeta,
      where: p.project_id == ^project_id,
      where: p.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get project metas
  """
  def get_project_metas(project_id) do
    from(
      p in ProjectMeta,
      where: p.project_id == ^project_id
    )
    |> Repo.all()
  end
end
