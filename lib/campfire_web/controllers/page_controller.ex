# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CampfireWeb.PageController do
  @moduledoc """
  Page Controller
  """
  use CampfireWeb, :controller

  alias Campfire.Module.InstallModule
  alias Campfire.Service.AuthService

  plug :auth

  defp auth(conn, _opts) do
    result =
      AuthService.is_authenticated(
        conn.req_cookies["_uid"],
        conn.req_cookies["_token"]
      )

    case result do
      false ->
        conn = assign(conn, :is_logged, false)
        conn = assign(conn, :user_id, "")
        conn = assign(conn, :sess_token, "")

      {true, session} ->
        conn = assign(conn, :is_logged, true)
        conn = assign(conn, :user_id, session.user_id)
        conn = assign(conn, :sess_token, session.value)
    end

    conn
  end

  @doc """
  Install Page
  """
  def install(conn, _params) do
    is_installed = InstallModule.is_installed()

    case is_installed do
      true ->
        redirect(conn, to: "/")

      false ->
        render(conn, "install.html")
    end
  end

  @doc """
  Home Page
  """
  def home(conn, _params) do
    is_installed = InstallModule.is_installed()

    case is_installed do
      false ->
        redirect(conn, to: "/install")

      true ->
        render(conn, "home.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            user_id: conn.assigns[:user_id],
            sess_token: conn.assigns[:sess_token]
          }
        )
    end
  end

  @doc """
  Login Page
  """
  def login(conn, _params) do
    is_installed = InstallModule.is_installed()

    case {is_installed, conn.assigns[:is_logged]} do
      {false, _} ->
        redirect(conn, to: "/install")

      {_, true} ->
        redirect(conn, to: "/")

      {true, _} ->
        render(conn, "login.html",
          data: %{
            is_logged: conn.assigns[:is_logged],
            user_id: conn.assigns[:user_id],
            sess_token: conn.assigns[:sess_token]
          }
        )
    end
  end

  @doc """
  Logout Action
  """
  def logout(conn, _params) do
    AuthService.logout(conn.assigns[:user_id])
    redirect(conn, to: "/")
  end

  @doc """
  Projects Page
  """
  def projects(conn, _params) do
    render(conn, "projects.html",
      data: %{
        is_logged: conn.assigns[:is_logged],
        user_id: conn.assigns[:user_id],
        sess_token: conn.assigns[:sess_token]
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
