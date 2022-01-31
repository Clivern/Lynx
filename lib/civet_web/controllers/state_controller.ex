# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.StateController do
  @moduledoc """
  State Controller
  """

  use CivetWeb, :controller
  # alias Civet.Context.LockContext
  # alias Civet.Service.ValidatorService

  @doc """
  Create State Endpoint
  """
  def create(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  @doc """
  View State Endpoint
  """
  def index(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  @doc """
  Delete State Endpoint
  """
  def delete(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
