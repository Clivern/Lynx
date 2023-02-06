# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Context.EnvironmentContext do
  @moduledoc """
  Environment Context Module
  """

  import Ecto.Query

  alias Bandit.Repo
  alias Bandit.Model.{Environment, EnvironmentMeta}

  @doc """
  Get a new environment
  """
  def new_env(attrs \\ %{}) do
    %{
      slug: attrs.slug,
      name: attrs.name,
      username: attrs.username,
      secret: attrs.secret,
      project_id: attrs.project_id,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Get a environment meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      environment_id: meta.environment_id
    }
  end

  @doc """
  Create a new environment
  """
  def create_env(attrs \\ %{}) do
    %Environment{}
    |> Environment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get Env ID with UUID
  """
  def get_env_id_with_uuid(uuid) do
    case get_env_by_uuid(uuid) do
      nil ->
        nil

      env ->
        env.id
    end
  end

  @doc """
  Retrieve a environment by ID
  """
  def get_env_by_id(id) do
    Repo.get(Environment, id)
  end

  @doc """
  Get environment by slug, project id, username and password
  """
  def get_env_by_slug_credentials(slug, project_id, username, secret) do
    from(
      e in Environment,
      where: e.slug == ^slug,
      where: e.project_id == ^project_id,
      where: e.username == ^username,
      where: e.secret == ^secret
    )
    |> Repo.one()
  end

  @doc """
  Get environment by uuid
  """
  def get_env_by_uuid(uuid) do
    from(
      e in Environment,
      where: e.uuid == ^env_uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Get environment by uuid and project id
  """
  def get_env_by_uuid_project(project_id, env_uuid) do
    from(
      e in Environment,
      where: e.project_id = ^project_id,
      where: e.uuid == ^env_uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Update a environment
  """
  def update_env(env, attrs) do
    env
    |> Environment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a environment
  """
  def delete_env(env) do
    Repo.delete(env)
  end

  @doc """
  Retrieve all environments
  """
  def get_envs() do
    Repo.all(Environment)
  end

  @doc """
  Retrieve project environments
  """
  def get_project_envs(project_id, offset, limit) do
    from(e in Environment,
      where: e.project_id = ^project_id,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Count project environments
  """
  def count_project_envs(project_id) do
    from(e in Environment,
      select: count(e.id),
      where: e.project_id = ^project_id
    )
    |> Repo.one()
  end

  @doc """
  Create a new environment meta
  """
  def create_env_meta(attrs \\ %{}) do
    %EnvironmentMeta{}
    |> EnvironmentMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a environment meta by id
  """
  def get_env_meta_by_id(id) do
    Repo.get(EnvironmentMeta, id)
  end

  @doc """
  Update a environment meta
  """
  def update_env_meta(env_meta, attrs) do
    env_meta
    |> EnvironmentMeta.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a environment meta
  """
  def delete_env_meta(env_meta) do
    Repo.delete(env_meta)
  end

  @doc """
  Get environment meta by environment id and key
  """
  def get_env_meta_by_id_key(env_id, meta_key) do
    from(
      e in EnvironmentMeta,
      where: e.environment_id == ^env_id,
      where: e.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get environment metas
  """
  def get_env_metas(env_id) do
    from(
      e in EnvironmentMeta,
      where: e.environment_id == ^env_id
    )
    |> Repo.all()
  end
end
