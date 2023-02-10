# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.ProfileController do
  @moduledoc """
  Profile Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.UserModule
  alias Lynx.Service.ValidatorService

  plug :regular_user when action in [:update]

  defp regular_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_logged] do
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
  Update Profile Endpoint
  """
  def update(conn, params) do
    result =
      UserModule.update_user(%{
        id: conn.assigns[:user_id],
        email: ValidatorService.get_str(params["email"], ""),
        name: ValidatorService.get_str(params["name"], "")
      })

    case result do
      {:not_found, _} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: "Invalid Request"})

      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> render("success.json", %{message: "Profile updated successfully"})

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: msg})
    end
  end
end
