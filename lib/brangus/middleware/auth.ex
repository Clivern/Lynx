# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Brangus.Service.AuthMiddleware do
  @moduledoc """
  Auth Middleware
  """
  import Plug.Conn

  alias Brangus.Service.AuthService

  @doc """
  UI Auth
  """
  def auth_ui(conn, _opts) do
    result =
      AuthService.is_authenticated(
        conn.req_cookies["_uid"],
        conn.req_cookies["_token"]
      )

    conn = case result do
      false ->
        assign(conn, :is_logged, false)
        |> assign(conn, :user_role, :anonymous)
        |> assign(conn, :user_id, "")
        |> assign(conn, :sess_token, "")

      {true, session} ->
        conn = case UserModule.get_user_by_id(session.user_id) do
          {:ok, user} ->
            assign(conn, :is_logged, true)
            |> assign(conn, :user_role, String.to_atom(user.role))
            |> assign(conn, :user_id, session.user_id)
            |> assign(conn, :sess_token, session.value)

          {:not_found, _} ->
            assign(conn, :is_logged, false)
            |> assign(conn, :user_role, :anonymous)
            |> assign(conn, :user_id, "")
            |> assign(conn, :sess_token, "")
        end

        conn
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
