# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.UserController do
  @moduledoc """
  User Controller
  """

  use LynxWeb, :controller

  alias Lynx.Module.UserModule
  alias Lynx.Exception.InvalidRequest
  alias Lynx.Service.ValidatorService
  alias Lynx.Service.AuthService
  alias Lynx.Module.SettingsModule

  require Logger

  @default_list_limit "10"
  @default_list_offset "0"

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
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)

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
    try do
      validate_create_request(params)

      email = ValidatorService.get_str(params["email"], "")
      name = ValidatorService.get_str(params["name"], "")
      role = ValidatorService.get_str(params["role"], "")
      password = ValidatorService.get_str(params["password"], "")
      api_key = AuthService.get_random_salt()
      app_key = SettingsModule.get_config("app_key", "")

      result =
        UserModule.create_user(%{
          name: name,
          email: email,
          api_key: api_key,
          role: role,
          password: password,
          app_key: app_key
        })

      case result do
        {:error, msg} ->
          Logger.info("Incoming request is invalid: #{msg}")
          raise InvalidRequest, message: "Invalid Request"

        {:ok, user} ->
          conn
          |> put_status(:created)
          |> render("index.json", %{user: user})
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
  Update Action Endpoint
  """
  def update(conn, _params) do
    # @TODO: User Update Endpoint
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Delete Action Endpoint
  """
  def delete(conn, %{"uuid" => uuid}) do
    Logger.info("Attempt to delete user with uuid #{uuid}")

    if conn.assigns[:user_uuid] == uuid do
      conn
      |> put_status(:bad_request)
      |> render("error.json", %{message: "User can't delete his account!"})
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

  defp validate_create_request(params) do
    email = ValidatorService.get_str(params["email"], "")
    name = ValidatorService.get_str(params["name"], "")
    role = ValidatorService.get_str(params["role"], "regular")
    password = ValidatorService.get_str(params["password"], "")

    if ValidatorService.is_empty(email) do
      raise InvalidRequest, message: "User email is required"
    end

    if ValidatorService.is_empty(name) do
      raise InvalidRequest, message: "User name is required"
    end

    if ValidatorService.is_empty(role) do
      raise InvalidRequest, message: "User role is required"
    end

    if ValidatorService.is_empty(password) do
      raise InvalidRequest, message: "User password is required"
    end

    if UserModule.is_email_used(email) do
      raise InvalidRequest, message: "Email is already used"
    end
  end
end
