# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CampfireWeb.MiscController do
  @moduledoc """
  Misc Controller
  """

  use CampfireWeb, :controller

  alias Campfire.Module.InstallModule
  alias Campfire.Service.ValidatorService
  alias Campfire.Service.AuthService

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
        |> render("error.json", %{error: "Application is installed"})
        |> halt()

      false ->
        nil
    end

    app_key = InstallModule.get_app_key()

    # Store configs
    config_results =
      InstallModule.store_configs(%{
        app_name: ValidatorService.get_str(params["app_name"], "Campfire"),
        app_url: ValidatorService.get_str(params["app_url"], "http://campfire.sh"),
        app_email: ValidatorService.get_str(params["app_email"], "no_reply@campfire.sh"),
        app_key: app_key
      })

    for config_result <- config_results do
      case config_result do
        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{error: msg})
          |> halt()

        :success ->
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
        |> render("error.json", %{error: msg})
        |> halt()

      :success ->
        nil
    end

    # Installation succeeded
    conn
    |> put_status(:ok)
    |> render("success.json", %{message: "Application installed successfully"})
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
        |> render("error.json", %{error: message})
        |> halt()
    end
  end

  @doc """
  Renew Token Endpoint
  """
  def renew_token(conn, params) do
    result =
      AuthService.is_authenticated(
        params["user_id"],
        params["token"]
      )

    case result do
      false ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid request"})
        |> halt()

      {true, session} ->
        case AuthService.refresh_session(session) do
          {:error, message} ->
            conn
            |> put_status(:bad_request)
            |> render("error.json", %{error: message})
            |> halt()

          {_, sess} ->
            conn
            |> put_status(:ok)
            |> render(
              "token_success.json",
              %{
                token: sess.value,
                user: sess.user_id
              }
            )
            |> halt()
        end
    end
  end
end
