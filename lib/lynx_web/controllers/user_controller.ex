# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.UserController do
  @moduledoc """
  User Controller
  """

  use LynxWeb, :controller

  alias Lynx.Module.UserModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Service.AuthService

  require Logger

  @name_min_length 2
  @name_max_length 60

  @default_list_limit 10
  @default_list_offset 0

  plug :super_user when action in [:list, :index, :create, :update, :delete]

  defp super_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_super] do
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

  @doc """
  List Action Endpoint
  """
  def list(conn, params) do
    limit = params["limit"] || @default_list_limit
    offset = params["offset"] || @default_list_offset

    render(conn, "list.json", %{
      users: UserModule.get_users(offset, limit),
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: UserModule.count_users()
      }
    })
  end

  @doc """
  Index Action Endpoint
  """
  def index(conn, %{"uuid" => uuid}) do
    case UserModule.get_user_by_uuid(uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("index.json", %{user: user})
    end
  end

  @doc """
  Create Action Endpoint
  """
  def create(conn, params) do
    case validate_create_request(params) do
      {:ok, _} ->
        result =
          UserModule.create_user(%{
            name: params["name"],
            email: params["email"],
            api_key: AuthService.get_uuid(),
            role: params["role"],
            password: params["password"]
          })

        case result do
          {:error, msg} ->
            Logger.info("Incoming request is invalid: #{msg}")

            conn
            |> put_status(:bad_request)
            |> render("error.json", %{message: "Invalid Request"})

          {:ok, user} ->
            conn
            |> put_status(:created)
            |> render("index.json", %{user: user})
        end

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
    end
  end

  @doc """
  Update Action Endpoint
  """
  def update(conn, params) do
    case validate_update_request(params, params["uuid"]) do
      {:ok, _} ->
        result =
          UserModule.update_user(%{
            uuid: params["uuid"],
            name: params["name"],
            email: params["email"],
            role: params["role"],
            password: params["password"]
          })

        case result do
          {:error, msg} ->
            Logger.info("Incoming request is invalid: #{msg}")

            conn
            |> put_status(:bad_request)
            |> render("error.json", %{message: "Invalid Request"})

          {:ok, user} ->
            conn
            |> put_status(:ok)
            |> render("index.json", %{user: user})
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
  def delete(conn, %{"uuid" => uuid}) do
    Logger.info("Attempt to delete user with uuid #{uuid}")

    if conn.assigns[:user_uuid] == uuid do
      conn
      |> put_status(:bad_request)
      |> render("error.json", %{message: "User can't delete his own account!"})
    else
      case UserModule.delete_user_by_uuid(uuid) do
        {:not_found, msg} ->
          conn
          |> put_status(:not_found)
          |> render("error.json", %{message: msg})

        {:ok, _} ->
          conn
          |> send_resp(:no_content, "")
      end
    end
  end

  defp validate_update_request(params, user_uuid) do
    errs = %{
      name_required: "User name is required",
      name_invalid: "User name is invalid",
      email_required: "User email is required",
      email_invalid: "User email is invalid",
      role_required: "User role is required",
      role_invalid: "User role is invalid",
      password_required: "User password is required",
      password_invalid:
        "User password is invalid, It must be alphanumeric and not less than 6 characters",
      email_used: "User email is already used"
    }

    case ValidatorService.is_not_empty?(params["password"], "") do
      {:ok, _} ->
        with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_string?(params["email"], errs.email_required),
             {:ok, _} <- ValidatorService.is_string?(params["role"], errs.role_required),
             {:ok, _} <- ValidatorService.is_string?(params["password"], errs.password_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["email"], errs.email_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["role"], errs.role_required),
             {:ok, _} <-
               ValidatorService.is_not_empty?(params["password"], errs.password_required),
             {:ok, _} <-
               ValidatorService.is_length_between?(
                 params["name"],
                 @name_min_length,
                 @name_max_length,
                 errs.name_invalid
               ),
             {:ok, _} <- ValidatorService.is_email?(params["email"], errs.email_invalid),
             {:ok, _} <-
               ValidatorService.in?(params["role"], ["regular", "super"], errs.role_invalid),
             {:ok, _} <- ValidatorService.is_password?(params["password"], errs.password_invalid),
             {:ok, _} <-
               ValidatorService.is_email_used?(params["email"], user_uuid, errs.email_used) do
          {:ok, ""}
        else
          {:error, reason} -> {:error, reason}
        end

      {:error, _} ->
        # password is not provided
        with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_string?(params["email"], errs.email_required),
             {:ok, _} <- ValidatorService.is_string?(params["role"], errs.role_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["email"], errs.email_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["role"], errs.role_required),
             {:ok, _} <-
               ValidatorService.is_length_between?(
                 params["name"],
                 @name_min_length,
                 @name_max_length,
                 errs.name_invalid
               ),
             {:ok, _} <- ValidatorService.is_email?(params["email"], errs.email_invalid),
             {:ok, _} <-
               ValidatorService.in?(params["role"], ["regular", "super"], errs.role_invalid),
             {:ok, _} <-
               ValidatorService.is_email_used?(params["email"], user_uuid, errs.email_used) do
          {:ok, ""}
        else
          {:error, reason} -> {:error, reason}
        end
    end
  end

  defp validate_create_request(params) do
    errs = %{
      name_required: "User name is required",
      name_invalid: "User name is invalid",
      email_required: "User email is required",
      email_invalid: "User email is invalid",
      role_required: "User role is required",
      role_invalid: "User role is invalid",
      password_required: "User password is required",
      password_invalid:
        "User password is invalid, It must be alphanumeric and not less than 6 characters",
      email_used: "User email is already used"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
         {:ok, _} <- ValidatorService.is_string?(params["email"], errs.email_required),
         {:ok, _} <- ValidatorService.is_string?(params["role"], errs.role_required),
         {:ok, _} <- ValidatorService.is_string?(params["password"], errs.password_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["email"], errs.email_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["role"], errs.role_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["password"], errs.password_required),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["name"],
             @name_min_length,
             @name_max_length,
             errs.name_invalid
           ),
         {:ok, _} <- ValidatorService.is_email?(params["email"], errs.email_invalid),
         {:ok, _} <-
           ValidatorService.in?(params["role"], ["regular", "super"], errs.role_invalid),
         {:ok, _} <- ValidatorService.is_password?(params["password"], errs.password_invalid),
         {:ok, _} <- ValidatorService.is_email_used?(params["email"], nil, errs.email_used) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
