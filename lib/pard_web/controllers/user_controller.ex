# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule PardWeb.UserController do
  @moduledoc """
  User Controller
  """

  use PardWeb, :controller

  alias Pard.Service.AuthService

  @doc """
  Auth Action Endpoint
  """
  def auth(conn, params) do
    result = AuthService.login(params["email"], params["password"])

    case result do
      {:success, session} ->
        conn
        |> put_status(:ok)
        |> render(
          "token_success.json",
          %{
            message: "User logged in successfully!",
            token: session.value,
            user: session.user_id
          }
        )
        |> halt()

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: message})
        |> halt()
    end
  end

  @doc """
  List Action Endpoint
  """
  def list(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Add Action Endpoint
  """
  def add(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Edit Action Endpoint
  """
  def edit(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end

  @doc """
  Delete Action Endpoint
  """
  def delete(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end
end
