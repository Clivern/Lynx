# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.ProjectController do
  @moduledoc """
  Project Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Exception.InvalidRequest
  alias Lynx.Module.ProjectModule
  alias Lynx.Module.TeamModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Module.PermissionModule

  @default_list_limit "10"
  @default_list_offset "0"

  plug :regular_user when action in [:list, :index, :create, :update, :delete]
  plug :access_check when action in [:index, :update, :delete]

  defp regular_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_logged] do
      Logger.info("User doesn't have the right access permissions")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
      |> halt
    else
      Logger.info("User has the right access permissions")

      conn
    end
  end

  defp access_check(conn, _opts) do
    Logger.info("Validate if user can access project")

    if not PermissionModule.can_access_project_uuid(
         :project,
         conn.assigns[:user_role],
         conn.params["uuid"],
         conn.assigns[:user_id]
       ) do
      Logger.info("User doesn't own the project")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
      |> halt
    else
      Logger.info("User can access the project")

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
    try do
      validate_create_request(params)

      slug = ValidatorService.get_str(params["slug"], "")
      team_id = TeamModule.get_team_id_with_uuid(ValidatorService.get_str(params["team_id"], ""))

      if ProjectModule.is_slug_used_in_team(slug, team_id) do
        raise InvalidRequest, message: "Team slug is used"
      end

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
          |> render("error.json", %{message: msg})
      end
    rescue
      e in InvalidRequest ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: e.message})

      _ ->
        conn
        |> put_status(:internal_server_error)
        |> render("error.json", %{message: "Internal server error"})
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
        |> render("error.json", %{message: msg})

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
    try do
      validate_update_request(params)

      result =
        ProjectModule.update_project(%{
          uuid: ValidatorService.get_str(params["uuid"], ""),
          name: ValidatorService.get_str(params["name"], ""),
          description: ValidatorService.get_str(params["description"], "")
        })

      case result do
        {:ok, project} ->
          conn
          |> put_status(:ok)
          |> render("index.json", %{project: project})

        {:not_found, msg} ->
          conn
          |> put_status(:not_found)
          |> render("error.json", %{message: msg})

        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{message: msg})
      end
    rescue
      e in InvalidRequest ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: e.message})

      _ ->
        conn
        |> put_status(:internal_server_error)
        |> render("error.json", %{message: "Internal server error"})
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
        |> render("error.json", %{message: msg})

      {:ok, _} ->
        conn
        |> send_resp(:no_content, "")
    end
  end

  defp validate_create_request(params) do
    errs = %{
      name_required: "Project name is required",
      name_invalid: "Project name is invalid",
      description_required: "Project description is required",
      description_invalid: "Project description is invalid",
      slug_required: "Project slug is required",
      slug_invalid: "Project slug is invalid",
      slug_used: "Project slug is already used",
      team_id_required: "Team is required"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["description"], errs.description_required),
         {:ok, _} <- ValidatorService.is_string?(params["slug"], errs.slug_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params["description"], errs.description_invalid),
         {:ok, _} <- ValidatorService.is_not_empty?(params["slug"], errs.slug_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["name"], 2, 60, errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["description"],
             2,
             250,
             errs.description_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["slug"], 2, 60, errs.slug_invalid),
         {:ok, _} <-
           ValidatorService.is_uuid?(params["team_id"], errs.team_id_required),
         {:ok, _} <-
           ValidatorService.is_project_slug_used?(
             params["slug"],
             params["team_id"],
             nil,
             errs.slug_used
           ) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp validate_update_request(params, project_uuid) do
    errs = %{
      name_required: "Project name is required",
      name_invalid: "Project name is invalid",
      description_required: "Project description is required",
      description_invalid: "Project description is invalid",
      slug_required: "Project slug is required",
      slug_invalid: "Project slug is invalid",
      slug_used: "Project slug is already used",
      team_id_required: "Team is required",
      project_id_required: "Project is required"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["description"], errs.description_required),
         {:ok, _} <- ValidatorService.is_string?(params["slug"], errs.slug_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params["description"], errs.description_invalid),
         {:ok, _} <- ValidatorService.is_not_empty?(params["slug"], errs.slug_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["name"], 2, 60, errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["description"],
             2,
             250,
             errs.description_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["slug"], 2, 60, errs.slug_invalid),
         {:ok, _} <-
           ValidatorService.is_uuid?(params["team_id"], errs.team_id_required),
         {:ok, _} <-
           ValidatorService.is_uuid?(project_uuid, errs.project_id_required),
         {:ok, _} <-
           ValidatorService.is_project_slug_used?(
             params["slug"],
             params["team_id"],
             project_uuid,
             errs.slug_used
           ) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
