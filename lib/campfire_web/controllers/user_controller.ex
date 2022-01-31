# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CampfireWeb.UserController do
  @moduledoc """
  User Controller
  """

  use CampfireWeb, :controller
  alias Campfire.Module.UserModule
  alias Campfire.Service.ValidatorService
  import Campfire.Service.AuthMiddleware

  @default_list_limit "10"
  @default_list_offset "0"

  plug :auth_ui, only: [:list, :add, :edit, :delete]
  plug :auth_api, only: [:list, :add, :edit, :delete]
  plug :only_super_user, only: [:list, :add, :edit, :delete]

  @doc """
  Allow only super users
  """
  def only_super_user(conn, _opts) do
    # If user not super, return forbidden access
    if conn.assigns[:user_role] != :super do
      conn
      |> put_status(:forbidden)
      |> render("error.json", %{error: "Forbidden Access"})
      |> halt()
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
  Add Action Endpoint
  """
  def add(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Edit Action Endpoint
  """
  def edit(conn, _params) do
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
