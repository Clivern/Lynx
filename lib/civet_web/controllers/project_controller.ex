# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.ProjectController do
  @moduledoc """
  Project Controller
  """

  use CivetWeb, :controller

  @doc """
  List Projects Endpoint
  """
  def list(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  @doc """
  Create Project Endpoint
  """
  def create(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  @doc """
  View Project Endpoint
  """
  def index(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  @doc """
  Update Project Endpoint
  """
  def update(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  @doc """
  Delete Project Endpoint
  """
  def delete(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
