# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BrangusWeb.ReadyController do
  @moduledoc """
  Ready Controller
  """

  use BrangusWeb, :controller
  require Logger

  @doc """
  Ready Endpoint
  """
  def ready(conn, _params) do
    Logger.info("Application is ready")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end
end
