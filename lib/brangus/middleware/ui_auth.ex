# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Brangus.Middleware.UIAuthMiddleware do
  @moduledoc """
  UI Auth Middleware
  """

  import Plug.Conn

  alias Brangus.Service.AuthService

  def init(_opts), do: nil

  @doc """
  Trigger the UI Auth Middleware

  To authenticate users into the UI, The app will set two cookies:
  _uid: User id
  _token: the session value
  """
  def call(conn, _opts) do
    uid = conn.req_cookies["_uid"]
    token = conn.req_cookies["_token"]

    # Logging
    if is_nil(uid) do
      Logger.info("_uid cookie is not in the request. RequestId=#{conn.assigns[:request_id]}")
    else
      Logger.info("_uid cookie is in the request. RequestId=#{conn.assigns[:request_id]}")
    end

    if is_nil(token) do
      Logger.info("_token cookie is not in the request. RequestId=#{conn.assigns[:request_id]}")
    else
      Logger.info("_token cookie is in the request. RequestId=#{conn.assigns[:request_id]}")
    end

    result = AuthService.is_authenticated(uid, token)

    # Adjust conn Object
    conn =
      case result do
        false ->
          conn
          |> assign(:is_logged, false)
          |> assign(:user_role, :anonymous)
          |> assign(:user_id, nil)

        {true, session} ->
          conn =
            case UserModule.get_user_by_id(session.user_id) do
              {:ok, user} ->
                conn
                |> assign(:is_logged, true)
                |> assign(:user_role, String.to_atom(user.role))
                |> assign(:user_id, session.user_id)

              {:not_found, _} ->
                conn
                |> assign(:is_logged, false)
                |> assign(:user_role, :anonymous)
                |> assign(:user_id, nil)
            end

          conn
      end

    conn
  end
end
