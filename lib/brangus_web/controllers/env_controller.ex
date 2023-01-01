# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BrangusWeb.EnvironmentController do
  @moduledoc """
  Environment Controller
  """

  use BrangusWeb, :controller
  require Logger

  @doc """
  List Action Endpoint
  """
  def list(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Create Action Endpoint
  """
  def create(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Index Action Endpoint
  """
  def index(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Update Action Endpoint
  """
  def update(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Delete Action Endpoint
  """
  def delete(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end
end
