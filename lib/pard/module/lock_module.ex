# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Module.LockModule do
  @moduledoc """
  Lock Module
  """

  alias Pard.Context.LockContext
  alias Pard.Context.ProjectContext
  alias Pard.Service.ValidatorService

  @doc """
  Lock action
  """
  def lock_action(params \\ %{}) do
    # Get project
    project =
      ProjectContext.get_project_by_name_environment(
        params[:project],
        params[:environment]
      )

    case project do
      nil ->
        {:not_found, "Project not found"}

      _ ->
        # Create a new lock
        lock =
          LockContext.new_lock(%{
            project_id: project.id,
            tf_uuid: ValidatorService.get_str(params[:tf_uuid], ""),
            tf_operation: ValidatorService.get_str(params[:tf_operation], ""),
            tf_info: ValidatorService.get_str(params[:tf_info], ""),
            tf_who: ValidatorService.get_str(params[:tf_who], ""),
            tf_version: ValidatorService.get_str(params[:tf_version], ""),
            tf_path: ValidatorService.get_str(params[:tf_path], ""),
            is_active: true
          })

        case LockContext.create_lock(lock) do
          {:ok, _} ->
            :success

          {:error, changeset} ->
            messages =
              changeset.errors()
              |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

            {:error, Enum.at(messages, 0)}
        end
    end
  end

  @doc """
  Check if a project is locked
  """
  def is_locked(params \\ %{}) do
    # Get project
    project =
      ProjectContext.get_project_by_name_environment(
        params[:project],
        params[:environment]
      )

    case project do
      nil ->
        {:not_found, "Project not found"}

      _ ->
        lock = LockContext.get_active_lock_by_project_id(project.id)

        case lock do
          nil ->
            :success

          _ ->
            {:locked, lock}
        end
    end
  end

  @doc """
  Unlock action
  """
  def unlock_action(params \\ %{}) do
    # Get project
    project =
      ProjectContext.get_project_by_name_environment(
        params[:project],
        params[:environment]
      )

    case project do
      nil ->
        {:not_found, "Project not found"}

      _ ->
        lock = LockContext.get_active_lock_by_project_id(project.id)

        case lock do
          nil ->
            :success

          _ ->
            result =
              LockContext.update_lock(lock, %{
                is_active: false
              })

            case result do
              {:ok, _} ->
                :success

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
