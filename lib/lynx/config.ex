defmodule Lynx.Config do
  @moduledoc """
  Runtime configuration helpers for the Lynx application.
  """

  @default_max_body_length 8_000_000

  @doc """
  Returns the configured HTTP request body size limit (in bytes).

  Reads `:http_max_body_length` from the `LynxWeb.Endpoint` application
  environment so the value can be overridden at runtime via
  `APP_HTTP_MAX_BODY_LENGTH` (see `config/runtime.exs`).
  """
  def max_body_length do
    Application.get_env(:lynx, LynxWeb.Endpoint, [])[:http_max_body_length] ||
      @default_max_body_length
  end
end
