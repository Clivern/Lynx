# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Brangus.Middleware.APIAuthMiddleware do
  @moduledoc """
  Frontend Auth Middleware
  """

  import Plug.Conn

  alias Brangus.Service.AuthService

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
              |> assign(:user_id, nil)

            {true, session} ->
              conn =
                case UserModule.get_user_by_id(session.user_id) do
                  {:ok, user} ->
                    conn
                    |> assign(:is_logged, true)
                    |> assign(:user_role, String.to_atom(user.role))
                    |> assign(:user_id, user.id)

                  {:not_found, _} ->
                    conn
                    |> assign(:is_logged, false)
                    |> assign(:user_role, :anonymous)
                    |> assign(:user_id, nil)
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
