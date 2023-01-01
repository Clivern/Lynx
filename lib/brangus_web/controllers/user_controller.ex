# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BrangusWeb.UserController do
  @moduledoc """
  User Controller
  """

  use BrangusWeb, :controller

  alias Brangus.Module.UserModule
  alias Brangus.Service.ValidatorService

  require Logger

  @default_list_limit "10"
  @default_list_offset "0"

  plug :only_super_users, only: [:list, :get, :add, :edit, :delete]

  defp only_super_users(conn, _opts) do

    Logger.info("Validate user permissions. requestId is #{conn.assigns[:request_id]}")

    # If user not authenticated, return forbidden access
    if conn.assigns[:is_logged] == false do
      Logger.info("User is not authenticated. requestId is #{conn.assigns[:request_id]}")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{error: "Forbidden Access"})
      |> halt()
    else
      # If user not super, return forbidden access
      if conn.assigns[:user_role] != :super do
        Logger.info(
          "User doesn't have a super permission. requestId is #{conn.assigns[:request_id]}"
        )

        conn
        |> put_status(:forbidden)
        |> render("error.json", %{error: "Forbidden Access"})
        |> halt()
      else
        Logger.info(
          "User with id #{conn.assigns[:user_id]} can access this endpoint. requestId is #{conn.assigns[:request_id]}"
        )
      end
    end

    conn
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
  Create Action Endpoint
  """
  def create(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Index Action Endpoint
  """
  def index(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Update Action Endpoint
  """
  def update(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Delete Action Endpoint
  """
  def delete(conn, %{"id" => id}) do
    result = UserModule.delete_user(id)

    case result do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:ok, _} ->
        conn
        |> send_resp(:no_content, "")

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: msg})
    end
  end
end
