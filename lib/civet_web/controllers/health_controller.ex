# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.HealthController do
  @moduledoc """
  Health Controller
  """

  use CivetWeb, :controller

  @doc """
  Health Endpoint
  """
  def health(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
