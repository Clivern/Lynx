# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.EnvironmentController do
  @moduledoc """
  Environment Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.ProjectModule
  alias Lynx.Module.EnvironmentModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Exception.InvalidRequest

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
  List Action Endpoint
  """
  def list(conn, params) do
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)

    result = EnvironmentModule.get_project_environments(params["p_uuid"], offset, limit)
    count = EnvironmentModule.count_project_environments(params["p_uuid"])

    case result do
      {:error, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:ok, environments} ->
        render(conn, "list.json", %{
          environments: environments,
          metadata: %{
            limit: limit,
            offset: offset,
            totalCount: count
          }
        })
    end
  end

  @doc """
  Create Action Endpoint
  """
  def create(conn, params) do
    try do
      validate_create_request(params)

      project_id =
        ProjectModule.get_project_id_with_uuid(ValidatorService.get_str(params["project_id"], ""))

      slug = ValidatorService.get_str(params["slug"], "")

      # Validate if slug is used before
      if EnvironmentModule.is_slug_used(project_id, slug) do
        raise InvalidRequest, message: "Environment slug is used"
      end

      result =
        EnvironmentModule.create_environment(%{
          name: ValidatorService.get_str(params["name"], ""),
          slug: ValidatorService.get_str(params["slug"], ""),
          username: ValidatorService.get_str(params["username"], ""),
          secret: ValidatorService.get_str(params["secret"], ""),
          project_id: project_id
        })

      case result do
        {:ok, environment} ->
          conn
          |> put_status(:created)
          |> render("index.json", %{environment: environment})

        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{error: msg})
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
  Index Action Endpoint
  """
  def index(conn, %{"p_uuid" => p_uuid, "e_uuid" => e_uuid}) do
    case EnvironmentModule.get_environment_by_uuid(p_uuid, e_uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:ok, environment} ->
        conn
        |> put_status(:ok)
        |> render("index.json", %{environment: environment})
    end
  end

  @doc """
  Update Action Endpoint
  """
  def update(conn, params) do
    try do
      validate_update_request(params)

      result =
        EnvironmentModule.update_environment(%{
          uuid: ValidatorService.get_str(params["e_uuid"], ""),
          name: ValidatorService.get_str(params["name"], ""),
          username: ValidatorService.get_str(params["username"], ""),
          secret: ValidatorService.get_str(params["secret"], "")
        })

      case result do
        {:ok, environment} ->
          conn
          |> put_status(:ok)
          |> render("index.json", %{environment: environment})

        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{error: msg})
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
  Delete Action Endpoint
  """
  def delete(conn, %{"p_uuid" => p_uuid, "e_uuid" => e_uuid}) do
    case EnvironmentModule.delete_environment_by_uuid(p_uuid, e_uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:ok, _} ->
        conn
        |> send_resp(:no_content, "")
    end
  end

  defp validate_create_request(params) do
    name = ValidatorService.get_str(params["name"], "")
    username = ValidatorService.get_str(params["username"], "")
    secret = ValidatorService.get_str(params["secret"], "")
    slug = ValidatorService.get_str(params["slug"], "")
    project_id = ValidatorService.get_str(params["project_id"], "")

    if ValidatorService.is_empty(name) do
      raise InvalidRequest, message: "Environment name is required"
    end

    if ValidatorService.is_empty(username) do
      raise InvalidRequest, message: "Environment username is required"
    end

    if ValidatorService.is_empty(secret) do
      raise InvalidRequest, message: "Environment secret is required"
    end

    if ValidatorService.is_empty(slug) do
      raise InvalidRequest, message: "Environment slug is required"
    end

    if ValidatorService.is_empty(project_id) do
      raise InvalidRequest, message: "Project ID is required"
    end
  end

  defp validate_update_request(params) do
    name = ValidatorService.get_str(params["name"], "")
    username = ValidatorService.get_str(params["username"], "")
    secret = ValidatorService.get_str(params["secret"], "")

    if ValidatorService.is_empty(name) do
      raise InvalidRequest, message: "Environment name is required"
    end

    if ValidatorService.is_empty(username) do
      raise InvalidRequest, message: "Environment username is required"
    end

    if ValidatorService.is_empty(secret) do
      raise InvalidRequest, message: "Environment secret is required"
    end
  end
end
