# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.ProjectContext do
  @moduledoc """
  Project Context Module
  """

  import Ecto.Query
  alias Civet.Repo
  alias Civet.Model.{ProjectMeta, Project}

  @doc """
  Get a new project
  """
  def new_project(project \\ %{}) do
    %{
      name: project.name,
      description: project.description,
      version: project.version,
      username: project.username,
      secret: project.secret,
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
      u in Project,
      where: u.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Get project by name and version
  """
  def get_project_by_name_version(name, version) do
    from(
      u in Project,
      where: u.name == ^name,
      where: u.version == ^version
    )
    |> Repo.one()
  end

  @doc """
  Get project by username and secret
  """
  def get_project_by_username_secret(username, secret) do
    from(
      u in Project,
      where: u.username == ^username,
      where: u.secret == ^secret
    )
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
  Retrieve projects
  """
  def get_projects(offset, limit) do
    from(u in Project,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
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
    ProjectMeta.changeset(project_meta, attrs)
    |> Repo.update()
  end

  @doc """
  Delete a project meta
  """
  def delete_project_meta(project_meta) do
    Repo.delete(project_meta)
  end

  @doc """
  Get project meta by project id and key
  """
  def get_project_meta_by_id_key(project_id, meta_key) do
    from(
      u in ProjectMeta,
      where: u.project_id == ^project_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get project metas
  """
  def get_project_metas(project_id) do
    from(
      u in ProjectMeta,
      where: u.project_id == ^project_id
    )
    |> Repo.all()
  end
end
