# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule RaccoonWeb.MiscController do
  @moduledoc """
  Misc Controller
  """

  use RaccoonWeb, :controller

  alias Raccoon.Module.InstallModule
  alias Raccoon.Service.ValidatorService
  alias Raccoon.Service.AuthService

  @doc """
  Install Action Endpoint
  """
  def install(conn, params) do
    # Check if application is installed
    is_installed = InstallModule.is_installed()

    case is_installed do
      true ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: "Application is installed"})
        |> halt()

      false ->
        nil
    end

    app_key = InstallModule.get_app_key()

    # Store configs
    config_results =
      InstallModule.store_configs(%{
        app_name: ValidatorService.get_str(params["app_name"], "Raccoon"),
        app_url: ValidatorService.get_str(params["app_url"], "http://raccoon.sh"),
        app_email: ValidatorService.get_str(params["app_email"], "no_reply@raccoon.sh"),
        app_key: app_key
      })

    for config_result <- config_results do
      case config_result do
        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{message: msg})
          |> halt()

        _ ->
          nil
      end
    end

    # Create admin account
    admin_result =
      InstallModule.create_admin(%{
        admin_name: ValidatorService.get_str(params["admin_name"], ""),
        admin_email: ValidatorService.get_str(params["admin_email"], ""),
        admin_password: ValidatorService.get_str(params["admin_password"], ""),
        app_key: app_key
      })

    case admin_result do
      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: msg})
        |> halt()

      _ ->
        conn
        |> put_status(:ok)
        |> render("success.json", %{message: "Application installed successfully"})
    end
  end

  @doc """
  Auth Action Endpoint
  """
  def auth(conn, params) do
    result =
      AuthService.login(
        params["email"],
        params["password"]
      )

    case result do
      {:success, session} ->
        conn
        |> put_status(:ok)
        |> render(
          "token_success.json",
          %{
            message: "User logged in successfully!",
            token: session.value,
            user: session.user_id
          }
        )
        |> halt()

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: message})
        |> halt()
    end
  end
end
