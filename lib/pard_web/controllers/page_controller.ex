# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule PardWeb.PageController do
  @moduledoc """
  Page Controller
  """
  use PardWeb, :controller

  alias Pard.Module.InstallModule
  alias Pard.Service.AuthService

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

      {true, session} ->
        conn = assign(conn, :is_logged, true)
        conn = assign(conn, :user_id, session.user_id)
        conn = assign(conn, :sess_token, session.value)
    end
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
        render(conn, "home.html", is_logged: false)
    end
  end

  @doc """
  Login Page
  """
  def login(conn, _params) do
    is_installed = InstallModule.is_installed()

    case is_installed do
      false ->
        redirect(conn, to: "/install")

      true ->
        render(conn, "login.html", is_logged: conn.assigns[:is_logged])
    end
  end

  @doc """
  Logout Action
  """
  def logout(conn, _params) do
    AuthService.logout(get_session(conn, :ses_uid))
    redirect(conn, to: "/")
  end

  @doc """
  Projects Page
  """
  def projects(conn, _params) do
    render(conn, "projects.html", is_logged: false)
  end

  @doc """
  Project Page
  """
  def project(conn, _params) do
    render(conn, "project.html", is_logged: false)
  end

  @doc """
  New Project Page
  """
  def new_project(conn, _params) do
    render(conn, "add_project.html", is_logged: false)
  end

  @doc """
  List Users Page
  """
  def users(conn, _params) do
    render(conn, "users.html", is_logged: false)
  end

  @doc """
  Add User Page
  """
  def new_user(conn, _params) do
    render(conn, "add_user.html", is_logged: false)
  end

  @doc """
  Edit User Page
  """
  def edit_user(conn, _params) do
    render(conn, "edit_user.html", is_logged: false)
  end

  @doc """
  Settings Page
  """
  def settings(conn, _params) do
    render(conn, "settings.html", is_logged: false)
  end
end
