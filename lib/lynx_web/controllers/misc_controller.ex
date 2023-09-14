# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.MiscController do
  @moduledoc """
  Misc Controller
  """

  use LynxWeb, :controller

  alias Lynx.Module.InstallModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Service.AuthService

  @doc """
  Install Action Endpoint
  """
  def install(conn, params) do
    if not InstallModule.is_installed() do
      case validate_install_request(params) do
        {:ok, _} ->
          app_key = InstallModule.get_app_key()

          InstallModule.store_configs(%{
            app_name: params[:app_name] || "Lynx",
            app_url: params[:app_url] || "http://lynx.sh",
            app_email: params[:app_email] || "no_reply@lynx.sh",
            app_key: app_key
          })

          InstallModule.create_admin(%{
            admin_name: params[:admin_name] || "",
            admin_email: params[:admin_email] || "",
            admin_password: params[:admin_password] || "",
            app_key: app_key
          })

          conn
          |> put_status(:ok)
          |> render("success.json", %{message: "Application installed successfully"})

        {:error, reason} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{message: reason})
      end
    else
      conn
      |> put_status(:bad_request)
      |> render("error.json", %{message: "Application is installed"})
    end
  end

  @doc """
  Auth Action Endpoint
  """
  def auth(conn, params) do
    err = "Invalid email or password!"

    with {:ok, _} <- ValidatorService.is_string?(params[:password], err),
         {:ok, password} <- ValidatorService.is_password?(params[:password], err),
         {:ok, _} <- ValidatorService.is_string?(params[:email], err),
         {:ok, email} <- ValidatorService.is_email?(params[:email], err) do
      # Authenticate
      case AuthService.login(email, password) do
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

        {:error, message} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{message: message})
      end
    else
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
    end
  end

  defp validate_install_request(params) do
    errs = %{
      app_name_required: "Application name is required",
      app_name_invalid: "Application name is invalid",
      app_url_required: "Application URL is required",
      app_url_invalid: "Application URL is invalid",
      app_email_required: "Application email is required",
      app_email_invalid: "Application email is invalid",
      admin_name_required: "User name is required",
      admin_name_invalid: "User name is invalid",
      admin_email_required: "User email is required",
      admin_email_invalid: "User email is invalid",
      admin_password_required: "User password is required",
      admin_password_invalid: "User password is invalid"
    }

    with {:ok, _} <- ValidatorService.is_string?(params[:app_name], errs.app_name_required),
         {:ok, _} <- ValidatorService.is_string?(params[:app_url], errs.app_url_required),
         {:ok, _} <- ValidatorService.is_string?(params[:app_email], errs.app_email_required),
         {:ok, _} <-
           ValidatorService.is_length_between?(params[:app_name], 2, 60, errs.app_name_invalid),
         {:ok, _} <- ValidatorService.is_url?(params[:app_url], 2, 60, errs.app_url_invalid),
         {:ok, _} <-
           ValidatorService.is_email?(params[:app_email], 2, 60, errs.app_email_invalid),
         {:ok, _} <- ValidatorService.is_string?(params[:admin_name], errs.admin_name_required),
         {:ok, _} <-
           ValidatorService.is_string?(params[:admin_email], errs.admin_email_required),
         {:ok, _} <-
           ValidatorService.is_string?(params[:admin_password], errs.admin_password_required),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params[:admin_name], errs.admin_name_required),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params[:admin_email], errs.admin_email_required),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params[:admin_password], errs.admin_password_required),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params[:admin_name],
             2,
             60,
             errs.admin_name_invalid
           ),
         {:ok, _} <- ValidatorService.is_email?(params[:admin_email], errs.admin_email_invalid),
         {:ok, _} <-
           ValidatorService.is_password?(params[:admin_password], errs.admin_password_invalid) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
