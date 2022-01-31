# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.LockController do
  @moduledoc """
  Lock Controller
  """

  use CivetWeb, :controller
  # alias Civet.Context.LockContext
  # alias Civet.Service.ValidatorService

  @doc """
  Lock Endpoint
  """
  def lock(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  @doc """
  Unlock Endpoint
  """
  def unlock(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
