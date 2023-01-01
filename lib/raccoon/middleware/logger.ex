# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Raccoon.Middleware.Logger do
  @moduledoc """
  Logger Middleware
  """

  import Plug.Conn

  require Logger

  def init(_opts), do: nil

  @doc """
  Log Incoming Request
  """
  def call(conn, _opts) do
    body = inspect(conn.body_params)

    {_, request_id} =
      Enum.find(conn.resp_headers, fn {key, _value} -> String.downcase(key) == "x-request-id" end) ||
        {nil, ""}

    # Log Incoming Request
    Logger.info(
      "Incoming #{conn.method} Request to #{conn.request_path}?#{conn.query_string} and body #{body}. RequestId=#{request_id}"
    )

    conn
    |> assign(:request_id, request_id)
  end
end
