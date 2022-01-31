# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.ProjectController do
  @moduledoc """
  Project Controller
  """

  use CivetWeb, :controller
  alias Civet.Context.ProjectContext
  alias Civet.Service.ValidatorService

  @default_list_limit "10"
  @default_list_offset "0"

  @doc """
  List Projects Endpoint
  """
  def list(conn, params) do
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)

    render(conn, "list.json", %{
      projects: ProjectContext.get_projects(offset, limit),
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: ProjectContext.count_projects()
      }
    })
  end

  @doc """
  Create Project Endpoint
  """
  def create(conn, params) do
    project =
      ProjectContext.new_project(%{
        name: ValidatorService.get_str(params["name"], ""),
        description: ValidatorService.get_str(params["description"], ""),
        version: ValidatorService.get_str(params["version"], ""),
        username: ValidatorService.get_str(params["username"], ""),
        secret: ValidatorService.get_str(params["secret"], "")
      })

    case ProjectContext.create_project(project) do
      {:ok, project} ->
        conn
        |> put_status(:created)
        |> render("index.json", %{project: project})

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: Enum.at(messages, 0)})
    end
  end

  @doc """
  View Project Endpoint
  """
  def index(conn, %{"id" => id}) do
    case ValidatorService.validate_int(id) do
      {_, ""} ->
        project =
          id
          |> ValidatorService.parse_int()
          |> ProjectContext.get_project_by_id()

        case project do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "Project with ID #{id} not found"})

          _ ->
            conn
            |> put_status(:ok)
            |> render("index.json", %{project: project})
        end

      :error ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid Project ID"})
    end
  end

  @doc """
  Update Project Endpoint
  """
  def update(conn, params) do
    id = params["id"]

    case ValidatorService.validate_int(id) do
      true ->
        project =
          id
          |> ValidatorService.parse_int()
          |> ProjectContext.get_project_by_id()

        case project do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "Project with ID #{id} not found"})

          _ ->
            new_project =
              ProjectContext.new_project(%{
                name: ValidatorService.get_str(params["name"], project.name),
                description: ValidatorService.get_str(params["description"], project.description),
                version: ValidatorService.get_str(params["version"], project.version),
                username: ValidatorService.get_str(params["username"], project.username),
                secret: ValidatorService.get_str(params["secret"], project.secret)
              })

            case ProjectContext.update_project(project, new_project) do
              {:ok, project} ->
                conn
                |> put_status(:ok)
                |> render("index.json", %{project: project})

              {:error, changeset} ->
                messages =
                  changeset.errors()
                  |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

                conn
                |> put_status(:bad_request)
                |> render("error.json", %{error: Enum.at(messages, 0)})
            end
        end

      false ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid Project ID"})
    end
  end

  @doc """
  Delete Project Endpoint
  """
  def delete(conn, %{"id" => id}) do
    case ValidatorService.validate_int(id) do
      true ->
        project =
          id
          |> ValidatorService.parse_int()
          |> ProjectContext.get_project_by_id()

        case project do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "Project with ID #{id} not found"})

          _ ->
            ProjectContext.delete_project(project)

            conn
            |> send_resp(:no_content, "")
        end

      false ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid Project ID"})
    end
  end
end
