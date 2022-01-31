# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Octopus.Module.ProjectModule do
  @moduledoc """
  Project Module
  """
  alias Octopus.Context.ProjectContext
  alias Octopus.Service.ValidatorService

  @doc """
  Validate Auth Data
  """
  def is_allowed(params \\ %{}) do
    project =
      ProjectContext.get_project_by_name_environment(
        params[:project],
        params[:environment]
      )

    case project do
      nil ->
        {:not_found, "Project not found"}

      _ ->
        case {project.username == params[:username], project.secret == params[:secret]} do
          {true, true} ->
            {:success, "A valid username and secret"}

          _ ->
            {:failed, "Invalid username or secret"}
        end
    end
  end

  @doc """
  Get Project
  """
  def get_project(id) do
    case ValidatorService.validate_int(id) do
      true ->
        project =
          id
          |> ValidatorService.parse_int()
          |> ProjectContext.get_project_by_id()

        case project do
          nil ->
            {:not_found, "Project with ID #{id} not found"}

          _ ->
            {:exist, project}
        end

      false ->
        {:error, "Invalid Project ID"}
    end
  end

  @doc """
  Update Project
  """
  def update_project(params \\ %{}) do
    id = params[:id]

    case ValidatorService.validate_int(id) do
      true ->
        project =
          id
          |> ValidatorService.parse_int()
          |> ProjectContext.get_project_by_id()

        case project do
          nil ->
            {:not_found, "Project with ID #{id} not found"}

          _ ->
            new_project =
              ProjectContext.new_project(%{
                name: ValidatorService.get_str(params[:name], project.name),
                description: ValidatorService.get_str(params[:description], project.description),
                environment: ValidatorService.get_str(params[:environment], project.environment),
                username: ValidatorService.get_str(params[:username], project.username),
                secret: ValidatorService.get_str(params[:secret], project.secret)
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

      false ->
        {:error, "Invalid Project ID"}
    end
  end

  @doc """
  Create Project
  """
  def create_project(params \\ %{}) do
    project =
      ProjectContext.new_project(%{
        name: params[:name],
        description: params[:description],
        environment: params[:environment],
        username: params[:username],
        secret: params[:secret]
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
  Delete A Project
  """
  def delete_project(id) do
    case ValidatorService.validate_int(id) do
      true ->
        project =
          id
          |> ValidatorService.parse_int()
          |> ProjectContext.get_project_by_id()

        case project do
          nil ->
            {:not_found, "Project with ID #{id} not found"}

          _ ->
            ProjectContext.delete_project(project)
            {:success, "Project with ID #{id} deleted successfully"}
        end

      false ->
        {:error, "Invalid Project ID"}
    end
  end
end
