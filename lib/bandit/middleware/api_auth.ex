# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Middleware.APIAuthMiddleware do
  @moduledoc """
  API Auth Middleware
  """

  import Plug.Conn

  require Logger

  alias Bandit.Service.AuthService
  alias Bandit.Module.UserModule

  def init(_opts), do: nil

  @doc """
  Trigger the API Auth Middleware
  """
  def call(conn, _opts) do
    {_, user_token} =
      Enum.find(conn.req_headers, fn {key, _value} -> String.downcase(key) == "x-user-token" end) ||
        {nil, nil}

    {_, user_id} =
      Enum.find(conn.req_headers, fn {key, _value} -> String.downcase(key) == "x-user-id" end) ||
        {nil, nil}

    {_, api_key} =
      Enum.find(conn.req_headers, fn {key, _value} -> String.downcase(key) == "x-api-key" end) ||
        {nil, nil}

    # Logging
    if is_nil(user_token) do
      Logger.info("X-USER-TOKEN header is not in the request")
    else
      Logger.info("X-USER-TOKEN header is in the request")
    end

    if is_nil(user_id) do
      Logger.info("X-USER-ID header is not in the request")
    else
      Logger.info("X-USER-ID header is in the request")
    end

    if is_nil(api_key) do
      Logger.info("X-API-KEY header is not in the request")
    else
      Logger.info("X-API-KEY header is in the request")
    end

    # Adjust conn Object
    conn =
      if is_nil(api_key) do
        # UI Authentication
        result = AuthService.is_authenticated(user_id, user_token)

        conn =
          case result do
            false ->
              conn
              |> assign(:is_logged, false)
              |> assign(:user_role, :anonymous)
              |> assign(:is_super, false)
              |> assign(:user_id, nil)
              |> assign(:user_name, nil)
              |> assign(:user_email, nil)

            {true, session} ->
              conn =
                case UserModule.get_user_by_id(session.user_id) do
                  {:ok, user} ->
                    conn
                    |> assign(:is_logged, true)
                    |> assign(:is_super, String.to_atom(user.role) == :super)
                    |> assign(:user_role, String.to_atom(user.role))
                    |> assign(:user_id, user.id)
                    |> assign(:user_name, user.name)
                    |> assign(:user_email, user.email)

                  {:not_found, _} ->
                    conn
                    |> assign(:is_logged, false)
                    |> assign(:is_super, false)
                    |> assign(:user_role, :anonymous)
                    |> assign(:user_id, nil)
                    |> assign(:user_name, nil)
                    |> assign(:user_email, nil)
                end

              conn
          end

        conn
      else
        # API Authentication
        result = AuthService.get_user_by_api(api_key)

        conn =
          case result do
            {:ok, user} ->
              conn
              |> assign(:is_logged, true)
              |> assign(:user_role, String.to_atom(user.role))
              |> assign(:user_id, user.id)

            _ ->
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
