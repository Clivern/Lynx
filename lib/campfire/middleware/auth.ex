# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Campfire.Service.AuthMiddleware do
  @moduledoc """
  Auth Middleware
  """
  import Plug.Conn

  alias Campfire.Service.AuthService

  @doc """
  UI Auth
  """
  def auth_ui(conn, _opts) do
    result =
      AuthService.is_authenticated(
        conn.req_cookies["_uid"],
        conn.req_cookies["_token"]
      )

    case result do
      false ->
        conn = assign(conn, :is_logged, false)
        conn = assign(conn, :user_role, :anonymous)
        conn = assign(conn, :user_id, "")
        conn = assign(conn, :sess_token, "")
        conn

      {true, session} ->
        case UserModule.get_user_by_id(session.user_id) do
          {:ok, user} ->
            conn = assign(conn, :is_logged, true)
            conn = assign(conn, :user_role, String.to_atom(user.role))
            conn = assign(conn, :user_id, session.user_id)
            conn = assign(conn, :sess_token, session.value)
            conn

          {:not_found, _} ->
            conn = assign(conn, :is_logged, false)
            conn = assign(conn, :user_role, :anonymous)
            conn = assign(conn, :user_id, "")
            conn = assign(conn, :sess_token, "")
            conn
        end
    end

    conn
  end

  @doc """
  API Auth
  """
  def auth_api(conn, _opts) do
    conn
  end
end
