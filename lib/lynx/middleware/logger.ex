# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Middleware.Logger do
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
    # Redact sensitive information from body_params
    sanitized_body = sanitize_body(conn.body_params)

    {_, request_id} =
      Enum.find(conn.resp_headers, fn {key, _value} -> String.downcase(key) == "x-request-id" end) ||
        {nil, ""}

    # Log Incoming Request with sanitized body
    Logger.info(
      "Incoming #{conn.method} Request to #{conn.request_path}?#{conn.query_string} and body #{inspect(sanitized_body)}"
    )

    conn
    |> assign(:request_id, request_id)
  end

  # Helper function to sanitize the body parameters
  defp sanitize_body(body_params) do
    body_params
    |> Enum.map(fn {key, value} ->
      if key in ["admin_password", "password"] do
        {key, "REDACTED"}
      else
        {key, value}
      end
    end)
    |> Enum.into(%{})
  end
end
