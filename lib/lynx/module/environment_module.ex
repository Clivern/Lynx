# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.EnvironmentModule do
  @moduledoc """
  Environment Module
  """

  alias Lynx.Context.LockContext
  alias Lynx.Context.TeamContext
  alias Lynx.Context.ProjectContext
  alias Lynx.Context.EnvironmentContext
  alias Lynx.Service.ValidatorService

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

  @doc """
  Get Project Environments
  """
  def get_project_environments(project_uuid, offset, limit) do
    case ProjectContext.get_project_by_uuid(project_uuid) do
      nil ->
        {:not_found, "Project with UUID #{project_uuid} not found"}

      project ->
        {:ok, EnvironmentContext.get_project_envs(project.id, offset, limit)}
    end
  end

  @doc """
  Count Project Environments
  """
  def count_project_environments(project_uuid) do
    case ProjectContext.get_project_by_uuid(project_uuid) do
      nil ->
        0

      project ->
        EnvironmentContext.count_project_envs(project.id)
    end
  end

  @doc """
  Update environment
  """
  def update_environment(data \\ %{}) do
    uuid = ValidatorService.get_str(data[:uuid], "")

    case EnvironmentContext.get_env_by_uuid(uuid) do
      nil ->
        {:not_found, "Environment with UUID #{uuid} not found"}

      env ->
        new_env =
          EnvironmentContext.new_env(%{
            name: ValidatorService.get_str(data[:name], env.name),
            username: ValidatorService.get_str(data[:username], env.username),
            secret: ValidatorService.get_str(data[:secret], env.secret),
            slug: env.slug,
            project_id: env.project_id
          })

        case EnvironmentContext.update_env(env, new_env) do
          {:ok, env} ->
            {:ok, env}

          {:error, changeset} ->
            messages =
              changeset.errors()
              |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

            {:error, Enum.at(messages, 0)}
        end
    end
  end

  @doc """
  Create environment
  """
  def create_environment(data \\ %{}) do
    env =
      EnvironmentContext.new_env(%{
        name: data[:name],
        slug: data[:slug],
        username: data[:username],
        secret: data[:secret],
        project_id: data[:project_id]
      })

    case EnvironmentContext.create_env(env) do
      {:ok, env} ->
        {:ok, env}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
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
  Validate Auth Data for environment
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
            case EnvironmentContext.get_env_by_slug_project(project.id, data[:env_slug]) do
              nil ->
                {:error, "Invalid environment credentials"}

              env ->
                if env.username == data[:username] and env.secret == data[:secret] do
                  {:ok, team, project, env}
                else
                  {:error, "Invalid environment credentials"}
                end
            end
        end
    end
  end

  @doc """
  Check if slug is used
  """
  def is_slug_used(project_id, slug) do
    case EnvironmentContext.get_env_by_slug_project(project_id, slug) do
      nil ->
        false

      _ ->
        true
    end
  end

  @doc """
  Count project envs
  """
  def count_project_envs(project_id) do
    EnvironmentContext.count_project_envs(project_id)
  end

  @doc """
  Check if environment is locked
  """
  def is_environment_locked(environment_id) do
    LockContext.is_environment_locked(environment_id)
  end
end
