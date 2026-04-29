defmodule LynxWeb.Plug.RuntimeParsers do
  @moduledoc """
  Thin wrapper around `Plug.Parsers` that resolves the body length limit
  at endpoint boot from the application environment, not at compile time.

  This is only effective when `config :phoenix, :plug_init_mode, :runtime`
  is set, so endpoint plug `init/1` callbacks run after `runtime.exs`.
  """

  @behaviour Plug

  @impl true
  def init(opts) do
    opts
    |> Keyword.put(:length, Lynx.Config.max_body_length())
    |> Plug.Parsers.init()
  end

  @impl true
  defdelegate call(conn, opts), to: Plug.Parsers
end
