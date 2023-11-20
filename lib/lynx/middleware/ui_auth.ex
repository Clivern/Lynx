# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Middleware.UIAuthMiddleware do
  @moduledoc """
  UI Auth Middleware
  """

  import Plug.Conn

  require Logger

  import Plug.Conn

  alias Lynx.Module.UserModule
  alias Lynx.Service.AuthService

  def init(_opts), do: nil

  @doc """
  Trigger the UI Auth Middleware

  To authenticate users into the UI, The app will set two cookies:
  _uid: User id
  _token: the session value
  """
  def call(conn, _opts) do
    conn = fetch_session(conn)

    token = get_session(conn, :token)
    uid = get_session(conn, :uid)

    # Logging
    if is_nil(uid) do
      Logger.info("uid cookie is not in the request")
    else
      Logger.info("uid cookie is in the request")
    end

    if is_nil(token) do
      Logger.info("token cookie is not in the request")
    else
      Logger.info("token cookie is in the request")
    end

    result = AuthService.is_authenticated(uid, token)

    # Adjust conn Object
    conn =
      case result do
        false ->
          conn
          |> assign(:is_logged, false)
          |> assign(:is_super, false)
          |> assign(:user_role, :anonymous)
          |> assign(:user_id, nil)
          |> assign(:user_name, nil)
          |> assign(:user_email, nil)
          |> assign(:user_uuid, nil)
          |> assign(:user_api_key, nil)

        {true, session} ->
          conn =
            case UserModule.get_user_by_id(session.user_id) do
              {:ok, user} ->
                conn
                |> assign(:is_logged, true)
                |> assign(:is_super, String.to_atom(user.role) == :super)
                |> assign(:user_role, String.to_atom(user.role))
                |> assign(:user_id, session.user_id)
                |> assign(:user_name, user.name)
                |> assign(:user_email, user.email)
                |> assign(:user_uuid, user.uuid)
                |> assign(:user_api_key, user.api_key)

              {:not_found, _} ->
                conn
                |> assign(:is_logged, false)
                |> assign(:is_super, false)
                |> assign(:user_role, :anonymous)
                |> assign(:user_id, nil)
                |> assign(:user_name, nil)
                |> assign(:user_email, nil)
                |> assign(:user_uuid, nil)
                |> assign(:user_api_key, nil)
            end

          conn
      end

    conn
  end
end
