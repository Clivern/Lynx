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

  plug :super_user when action in [:update]

  defp super_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_super] do
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
  Update Action Endpoint
  """
  def update(conn, params) do
    case validate_update_request(params) do
      {:ok, _} ->
        SettingsModule.update_configs(%{
          app_name: params[:app_name],
          app_url: params[:app_url],
          app_email: params[:app_email]
        })

        conn
        |> put_status(:ok)
        |> render("success.json", %{message: "Settings updated successfully"})

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
    end
  end

  defp validate_update_request(params) do
    errs = %{
      app_name_required: "Application name is required",
      app_name_invalid: "Application name is invalid",
      app_url_required: "Application URL is required",
      app_url_invalid: "Application URL is invalid",
      app_email_required: "Application email is required",
      app_email_invalid: "Application email is invalid"
    }

    with {:ok, _} <- ValidatorService.is_string?(params[:app_name], errs.app_name_required),
         {:ok, _} <- ValidatorService.is_string?(params[:app_url], errs.app_url_required),
         {:ok, _} <- ValidatorService.is_string?(params[:app_email], errs.app_email_required),
         {:ok, _} <-
           ValidatorService.is_length_between?(params[:app_name], 2, 60, errs.app_name_invalid),
         {:ok, _} <- ValidatorService.is_url?(params[:app_url], errs.app_url_invalid),
         {:ok, _} <-
           ValidatorService.is_email?(params[:app_email], errs.app_email_invalid) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
