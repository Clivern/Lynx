# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.EnvironmentController do
  @moduledoc """
  Environment Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.EnvironmentModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Module.PermissionModule

  @name_min_length 2
  @name_max_length 60
  @username_min_length 2
  @username_max_length 60
  @secret_min_length 2
  @secret_max_length 60
  @slug_min_length 2
  @slug_max_length 60

  @default_list_limit 10
  @default_list_offset 0

  plug :regular_user when action in [:list, :index, :create, :update, :delete]
  plug :access_check when action in [:list, :index, :create, :update, :delete]

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
         conn.params[:p_uuid],
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
  List Action Endpoint
  """
  def list(conn, params) do
    limit = params[:limit] || @default_list_limit
    offset = params[:offset] || @default_list_offset

    result = EnvironmentModule.get_project_environments(params[:p_uuid], offset, limit)
    count = EnvironmentModule.count_project_environments(params[:p_uuid])

    case result do
      {:error, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

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
    case validate_create_request(params, params[:p_uuid]) do
      {:ok, ""} ->
        result =
          EnvironmentModule.create_environment(%{
            name: params[:name],
            slug: params[:slug],
            username: params[:username],
            secret: params[:secret],
            project_id: params[:p_uuid]
          })

        case result do
          {:ok, environment} ->
            conn
            |> put_status(:created)
            |> render("index.json", %{environment: environment})

          {:error, msg} ->
            conn
            |> put_status(:bad_request)
            |> render("error.json", %{message: msg})
        end

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
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
        |> render("error.json", %{message: msg})

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
    case validate_update_request(params, params[:p_uuid], params[:e_uuid]) do
      {:ok, ""} ->
        result =
          EnvironmentModule.create_environment(%{
            uuid: params[:e_uuid],
            name: params[:name],
            slug: params[:slug],
            username: params[:username],
            secret: params[:secret],
            project_id: params[:p_uuid]
          })

        case result do
          {:ok, environment} ->
            conn
            |> put_status(:ok)
            |> render("index.json", %{environment: environment})

          {:error, msg} ->
            conn
            |> put_status(:bad_request)
            |> render("error.json", %{message: msg})
        end

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
    end
  end

  @doc """
  Delete Action Endpoint
  """
  def delete(conn, %{:p_uuid => p_uuid, :e_uuid => e_uuid}) do
    case EnvironmentModule.delete_environment_by_uuid(p_uuid, e_uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

      {:ok, _} ->
        conn
        |> send_resp(:no_content, "")
    end
  end

  defp validate_create_request(params, project_uuid) do
    errs = %{
      name_required: "Environment name is required",
      name_invalid: "Environment name is invalid",
      username_required: "Environment username is required",
      username_invalid: "Environment username is invalid",
      secret_required: "Environment secret is required",
      secret_invalid: "Environment secret is invalid",
      slug_required: "Environment slug is required",
      slug_invalid: "Environment slug is invalid",
      slug_used: "Environment slug is already used",
      project_uuid_invalid: "Project ID is invalid"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
         {:ok, _} <- ValidatorService.is_string?(params["username"], errs.username_required),
         {:ok, _} <- ValidatorService.is_string?(params["secret"], errs.secret_required),
         {:ok, _} <- ValidatorService.is_string?(params["slug"], errs.slug_required),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["name"],
             @name_min_length,
             @name_max_length,
             errs.name_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["username"],
             @username_min_length,
             @username_max_length,
             errs.username_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["secret"],
             @secret_min_length,
             @secret_max_length,
             errs.secret_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["slug"],
             @slug_min_length,
             @slug_max_length,
             errs.slug_invalid
           ),
         {:ok, _} <- ValidatorService.is_uuid?(project_uuid, errs.project_uuid_invalid),
         {:ok, _} <-
           ValidatorService.is_environment_slug_used?(
             params["slug"],
             project_uuid,
             nil,
             errs.slug_used
           ) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp validate_update_request(params, project_uuid, environment_uuid) do
    errs = %{
      name_required: "Environment name is required",
      name_invalid: "Environment name is invalid",
      username_required: "Environment username is required",
      username_invalid: "Environment username is invalid",
      secret_required: "Environment secret is required",
      secret_invalid: "Environment secret is invalid",
      slug_required: "Environment slug is required",
      slug_invalid: "Environment slug is invalid",
      slug_used: "Environment slug is already used",
      project_uuid_invalid: "Project ID is invalid"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
         {:ok, _} <- ValidatorService.is_string?(params["username"], errs.username_required),
         {:ok, _} <- ValidatorService.is_string?(params["secret"], errs.secret_required),
         {:ok, _} <- ValidatorService.is_string?(params["slug"], errs.slug_required),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["name"],
             @name_min_length,
             @name_max_length,
             errs.name_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["username"],
             @username_min_length,
             @username_max_length,
             errs.username_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["secret"],
             @secret_min_length,
             @secret_max_length,
             errs.secret_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["slug"],
             @slug_min_length,
             @slug_max_length,
             errs.slug_invalid
           ),
         {:ok, _} <- ValidatorService.is_uuid?(project_uuid, errs.project_uuid_invalid),
         {:ok, _} <-
           ValidatorService.is_environment_slug_used?(
             params["slug"],
             project_uuid,
             environment_uuid,
             errs.slug_used
           ) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
