# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Module.LockModule do
  @moduledoc """
  Lock Module
  """

  alias Bandit.Context.LockContext
  alias Bandit.Context.ProjectContext
  alias Bandit.Context.TeamContext
  alias Bandit.Context.EnvironmentContext

  @doc """
  Lock an environment
  """
  def lock_action(params \\ %{}) do
    case TeamContext.get_team_by_slug(params[:t_slug]) do
      nil ->
        {:not_found, "Team not found"}

      team ->
        case ProjectContext.get_project_by_slug_team_id(params[:p_slug], team.id) do
          nil ->
            {:not_found, "Project not found"}

          project ->
            case EnvironmentContext.get_env_by_slug_project(project.id, params[:e_slug]) do
              nil ->
                {:not_found, "Environment not found"}

              env ->
                lock =
                  LockContext.new_lock(%{
                    environment_id: env.id,
                    operation: params[:operation],
                    info: params[:info],
                    who: params[:who],
                    version: params[:version],
                    path: params[:path],
                    is_active: true
                  })

                case LockContext.create_lock(lock) do
                  {:ok, _} ->
                    {:success, ""}

                  {:error, changeset} ->
                    messages =
                      changeset.errors()
                      |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

                    {:error, Enum.at(messages, 0)}
                end
            end
        end
    end
  end

  @doc """
  Check if environment is locked
  """
  def is_locked(params \\ %{}) do
    case TeamContext.get_team_by_slug(params[:t_slug]) do
      nil ->
        {:not_found, "Team not found"}

      team ->
        case ProjectContext.get_project_by_slug_team_id(params[:p_slug], team.id) do
          nil ->
            {:not_found, "Project not found"}

          project ->
            case EnvironmentContext.get_env_by_slug_project(project.id, params[:e_slug]) do
              nil ->
                {:not_found, "Environment not found"}

              env ->
                case LockContext.get_active_lock_by_environment_id(env.id) do
                  nil ->
                    {:success, ""}

                  lock ->
                    {:locked, lock}
                end
            end
        end
    end
  end

  @doc """
  Unlock an environment
  """
  def unlock_action(params \\ %{}) do
    case TeamContext.get_team_by_slug(params[:t_slug]) do
      nil ->
        {:not_found, "Team not found"}

      team ->
        case ProjectContext.get_project_by_slug_team_id(params[:p_slug], team.id) do
          nil ->
            {:not_found, "Project not found"}

          project ->
            case EnvironmentContext.get_env_by_slug_project(project.id, params[:e_slug]) do
              nil ->
                {:not_found, "Environment not found"}

              env ->
                case LockContext.get_active_lock_by_environment_id(env.id) do
                  nil ->
                    {:success, ""}

                  lock ->
                    result =
                      LockContext.update_lock(lock, %{
                        is_active: false
                      })

                    case result do
                      {:ok, _} ->
                        {:success, ""}

                      {:error, changeset} ->
                        messages =
                          changeset.errors()
                          |> Enum.map(fn {field, {message, _options}} ->
                            "#{field}: #{message}"
                          end)

                        {:error, Enum.at(messages, 0)}
                    end
                end
            end
        end
    end
  end
end
