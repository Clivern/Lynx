# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule PardWeb.PageController do
  @moduledoc """
  Page Controller
  """
  use PardWeb, :controller

  alias Pard.Module.InstallModule

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
    render(conn, "login.html", is_logged: false)
  end

  @doc """
  Logout Action
  """
  def logout(_conn, _params) do
    nil
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
