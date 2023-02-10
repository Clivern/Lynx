# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.ReadyController do
  @moduledoc """
  Ready Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.SettingsModule

  @doc """
  Ready Endpoint
  """
  def ready(conn, _params) do
    Logger.info("Application is ready")

    app_name = SettingsModule.get_config("app_name", "")

    if app_name == "" do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:internal_server_error, Jason.encode!(%{status: "not ok"}))
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:ok, Jason.encode!(%{status: "ok"}))
    end
  end
end
