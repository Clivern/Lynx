# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.SettingsController do
  @moduledoc """
  Settings Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.SettingsModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Exception.InvalidRequest

  plug :super_user, only: [:update]

  defp super_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_super] do
      Logger.info("User doesn't have the right access permissions")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
    else
      Logger.info("User has the right access permissions")

      conn
    end
  end

  @doc """
  Update Action Endpoint
  """
  def update(conn, params) do
    try do
      validate_update_request(params)

      app_name = ValidatorService.get_str(params["app_name"], "")
      app_url = ValidatorService.get_str(params["app_url"], "")
      app_email = ValidatorService.get_str(params["app_email"], "")

      config_results =
        SettingsModule.update_configs(%{
          app_name: app_name,
          app_url: app_url,
          app_email: app_email
        })

      for config_result <- config_results do
        case config_result do
          {:error, msg} ->
            Logger.info("Request is invalid: #{msg}")
            raise InvalidRequest, message: "Invalid Request"

          _ ->
            nil
        end
      end
    rescue
      e in InvalidRequest ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: e.message})

      _ ->
        conn
        |> put_status(:internal_server_error)
        |> render("error.json", %{message: "Internal server error"})
    else
      _ ->
        conn
        |> put_status(:ok)
        |> render("success.json", %{message: "Settings updated successfully"})
    end
  end

  defp validate_update_request(params) do
    app_name = ValidatorService.get_str(params["app_name"], "")
    app_url = ValidatorService.get_str(params["app_url"], "")
    app_email = ValidatorService.get_str(params["app_email"], "")

    if ValidatorService.is_empty(app_name) do
      raise InvalidRequest, message: "Application name is required"
    end

    if ValidatorService.is_empty(app_url) do
      raise InvalidRequest, message: "Application URL is required"
    end

    if ValidatorService.is_empty(app_email) do
      raise InvalidRequest, message: "Application email is required"
    end
  end
end
