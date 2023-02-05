# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.PageController do
  @moduledoc """
  Page Controller
  """
  use BanditWeb, :controller

  alias Bandit.Module.InstallModule
  alias Bandit.Service.AuthService

  @doc """
  Login Page
  """
  def login(conn, _params) do
    is_installed = InstallModule.is_installed()

    case {is_installed, conn.assigns[:is_logged]} do
      {false, _} ->
        conn
        |> redirect(to: "/install")

      {_, true} ->
        conn
        |> redirect(to: "/admin/dashboard")

      {true, _} ->
        conn
        |> render("login.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email]
          }
        )
    end
  end

  @doc """
  Logout Action
  """
  def logout(conn, _params) do
    AuthService.logout(conn.assigns[:user_id])

    conn
    |> clear_session()
    |> redirect(to: "/")
  end

  @doc """
  Install Page
  """
  def install(conn, _params) do
    is_installed = InstallModule.is_installed()

    case is_installed do
      true ->
        conn
        |> redirect(to: "/")

      false ->
        conn
        |> render("install.html")
    end
  end

  @doc """
  Home Page
  """
  def home(conn, _params) do
    is_installed = InstallModule.is_installed()

    case is_installed do
      false ->
        conn
        |> redirect(to: "/install")

      true ->
        conn
        |> render("home.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email]
          }
        )
    end
  end

  @doc """
  Not Found Page
  """
  def not_found(conn, _params) do
    is_installed = InstallModule.is_installed()

    case is_installed do
      false ->
        conn
        |> redirect(to: "/install")

      true ->
        conn
        |> render("404.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email]
          }
        )
    end
  end

  @doc """
  Dashboard Page
  """
  def dashboard(conn, _params) do
    case conn.assigns[:is_logged] do
      false ->
        conn
        |> redirect(to: "/")

      true ->
        conn
        |> render("dashboard.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email]
          }
        )
    end
  end

  @doc """
  Profile Page
  """
  def profile(conn, _params) do
    case conn.assigns[:is_logged] do
      false ->
        conn
        |> redirect(to: "/")

      true ->
        conn
        |> render("profile.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email]
          }
        )
    end
  end

  @doc """
  Teams List Page
  """
  def teams(conn, _params) do
    case conn.assigns[:is_super] do
      false ->
        conn
        |> redirect(to: "/")

      true ->
        conn
        |> render("teams.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email]
          }
        )
    end
  end

  @doc """
  Users List Page
  """
  def users(conn, _params) do
    case conn.assigns[:is_super] do
      false ->
        conn
        |> redirect(to: "/")

      true ->
        conn
        |> render("users.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email]
          }
        )
    end
  end

  @doc """
  Settings Page
  """
  def settings(conn, _params) do
    case conn.assigns[:is_super] do
      false ->
        conn
        |> redirect(to: "/")

      true ->
        conn
        |> render("settings.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            is_super: conn.assigns[:is_super],
            user_name: conn.assigns[:user_name],
            user_email: conn.assigns[:user_email],
            app_name: SettingsModule.get_config("app_name", ""),
            app_url: SettingsModule.get_config("app_url", ""),
            app_email: SettingsModule.get_config("app_email", "")
          }
        )
    end
  end

  @doc """
  Projects Page
  """
  def projects(conn, _params) do
    render(conn, "projects.html",
      data: %{
        is_logged: conn.assigns[:is_logged],
        user_id: conn.assigns[:user_id],
        user_token: conn.assigns[:user_token]
      }
    )
  end

  @doc """
  Project Page
  """
  def project(conn, _params) do
    render(conn, "project.html", is_logged: conn.assigns[:is_logged])
  end

  @doc """
  New Project Page
  """
  def new_project(conn, _params) do
    render(conn, "add_project.html", is_logged: conn.assigns[:is_logged])
  end

  @doc """
  List Users Page
  """
  def users(conn, _params) do
    render(conn, "users.html", is_logged: conn.assigns[:is_logged])
  end

  @doc """
  Add User Page
  """
  def new_user(conn, _params) do
    render(conn, "add_user.html", is_logged: conn.assigns[:is_logged])
  end

  @doc """
  Edit User Page
  """
  def edit_user(conn, _params) do
    render(conn, "edit_user.html", is_logged: conn.assigns[:is_logged])
  end

  @doc """
  Settings Page
  """
  def settings(conn, _params) do
    render(conn, "settings.html", is_logged: conn.assigns[:is_logged])
  end
end
