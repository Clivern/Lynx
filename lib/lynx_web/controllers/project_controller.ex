# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.ProjectController do
  @moduledoc """
  Project Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.ProjectModule
  alias Lynx.Module.TeamModule
  alias Lynx.Service.ValidatorService

  @default_list_limit "10"
  @default_list_offset "0"

  plug :regular_user, only: [:list, :index, :create, :update, :delete]

  defp regular_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_logged] do
      Logger.info("User doesn't have the right access permissions")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
    else
      Logger.info("User has the right access permissions")

      conn
    end
  end

  @doc """
  List Projects Endpoint
  """
  def list(conn, params) do
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)

    {projects, count} =
      if conn.assigns[:is_super] do
        {ProjectModule.get_projects(offset, limit), ProjectModule.count_projects()}
      else
        {ProjectModule.get_projects(conn.assigns[:user_id], offset, limit),
         ProjectModule.count_projects(conn.assigns[:user_id])}
      end

    render(conn, "list.json", %{
      projects: projects,
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: count
      }
    })
  end

  @doc """
  Create Project Endpoint
  """
  def create(conn, params) do
    # Get Team ID from UUID
    team_id = TeamModule.get_team_id_with_uuid(ValidatorService.get_str(params["team_id"], ""))

    result =
      ProjectModule.create_project(%{
        name: ValidatorService.get_str(params["name"], ""),
        description: ValidatorService.get_str(params["description"], ""),
        slug: ValidatorService.get_str(params["slug"], ""),
        team_id: team_id
      })

    case result do
      {:ok, project} ->
        conn
        |> put_status(:created)
        |> render("index.json", %{project: project})

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: msg})
    end
  end

  @doc """
  Index Project Endpoint
  """
  def index(conn, %{"uuid" => uuid}) do
    case ProjectModule.get_project_by_uuid(uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:ok, project} ->
        conn
        |> put_status(:ok)
        |> render("index.json", %{project: project})
    end
  end

  @doc """
  Update Project Endpoint
  """
  def update(conn, params) do
    # Get Team ID from UUID
    team_id = TeamModule.get_team_id_with_uuid(ValidatorService.get_str(params["team_id"], ""))

    result =
      ProjectModule.update_project(%{
        uuid: ValidatorService.get_str(params["uuid"], ""),
        name: ValidatorService.get_str(params["name"], ""),
        description: ValidatorService.get_str(params["description"], ""),
        team_id: team_id
      })

    case result do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: msg})

      {:ok, project} ->
        conn
        |> put_status(:ok)
        |> render("index.json", %{project: project})
    end
  end

  @doc """
  Delete Project Endpoint
  """
  def delete(conn, %{"uuid" => uuid}) do
    case ProjectModule.delete_project_by_uuid(uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:ok, _} ->
        conn
        |> send_resp(:no_content, "")
    end
  end
end
