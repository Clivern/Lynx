# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.TaskController do
  @moduledoc """
  Task Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.TaskModule

  plug :regular_user when action in [:index]

  defp regular_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_logged] do
      Logger.info("User doesn't have the right access permissions")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
      |> halt
    else
      Logger.info("User has the right access permissions")

      conn
    end
  end

  @doc """
  Index Action Endpoint
  """
  def index(conn, %{"uuid" => uuid}) do
    case TaskModule.get_task_by_uuid(uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

      {:ok, task} ->
        conn
        |> put_status(:ok)
        |> render("index.json", %{task: task})
    end
  end
end
