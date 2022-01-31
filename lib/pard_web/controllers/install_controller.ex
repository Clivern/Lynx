# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule PardWeb.InstallController do
  @moduledoc """
  Install Controller
  """

  use PardWeb, :controller

  alias Pard.Module.InstallModule
  alias Pard.Service.ValidatorService

  @doc """
  Install Action Endpoint
  """
  def action(conn, params) do
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
    config_result =
      InstallModule.store_configs(%{
        app_name: ValidatorService.get_str(params["app_name"], "Prad"),
        app_url: ValidatorService.get_str(params["app_url"], "http://prad.sh"),
        app_email: ValidatorService.get_str(params["app_email"], "no_reply@prad.sh"),
        app_key: app_key
      })

    case config_result do
      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: msg})
        |> halt()

      :success ->
        nil
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
end
