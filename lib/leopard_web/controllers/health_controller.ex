# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LeopardWeb.HealthController do
  @moduledoc """
  Health Controller
  """

  use LeopardWeb, :controller

  @doc """
  Health Endpoint
  """
  def health(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end
end
