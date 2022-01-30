# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule PardWeb.PageController do
  @moduledoc """
  Page Controller
  """

  use PardWeb, :controller

  @doc """
  Home Page
  """
  def home(conn, _params) do
    render(conn, "home.html", is_logged: false)
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
  def logout(conn, _params) do
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
    render(conn, "new_project.html", is_logged: false)
  end
end
