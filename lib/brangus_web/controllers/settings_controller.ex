# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BrangusWeb.SettingsController do
  @moduledoc """
  Settings Controller
  """

  use BrangusWeb, :controller

  require Logger

  plug :only_super_users, only: [:update]

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
  Update Action Endpoint
  """
  def update(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end
end
