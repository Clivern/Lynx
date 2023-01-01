# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Brangus.Context.EnvironmentContext do
  @moduledoc """
  Environment Context Module
  """

  import Ecto.Query
  alias Brangus.Repo
  alias Brangus.Model.{Environment, EnvironmentMeta}

  @doc """
  Get a new environment
  """
  def new_env(env \\ %{}) do
    %{
      slug: env.slug,
      name: env.name,
      username: env.username,
      secret: env.secret,
      project_id: env.project_id,
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
  Retrieve a environment by ID
  """
  def get_env_by_id(id) do
    Repo.get(Environment, id)
  end

  @doc """
  Get environment by slug
  """
  def get_env_by_slug(slug) do
    from(
      e in Environment,
      where: e.slug == ^slug
    )
    |> Repo.one()
  end

  @doc """
  Get environment by uuid
  """
  def get_env_by_uuid(uuid) do
    from(
      e in Environment,
      where: e.uuid == ^uuid
    )
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
  Retrieve environments
  """
  def get_envs(offset, limit) do
    from(e in Environment,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
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
    EnvironmentMeta.changeset(env_meta, attrs)
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
