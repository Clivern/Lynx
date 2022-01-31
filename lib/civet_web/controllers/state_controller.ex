# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.StateController do
  @moduledoc """
  State Controller
  """

  use CivetWeb, :controller
  alias Civet.Module.StateModule
  alias Civet.Service.ValidatorService

  @doc """
  Create State Endpoint
  """
  def create(conn, params) do
    body = Map.drop(params, ["project", "environment"]) |> Jason.encode!()

    result =
      StateModule.add_state(%{
        project: ValidatorService.get_str(params["project"], ""),
        environment: ValidatorService.get_str(params["environment"], ""),
        state_name: "_tf_state_",
        state_value: body
      })

    case result do
      {:not_found, _} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{
          message: "Project not found"
        })

      {:ok, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, body)

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{
          message: msg
        })
    end
  end

  @doc """
  View State Endpoint
  """
  def index(conn, params) do
    result =
      StateModule.get_latest_state(%{
        project: ValidatorService.get_str(params["project"], ""),
        environment: ValidatorService.get_str(params["environment"], "")
      })

    case result do
      {:not_found, _} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{
          message: "Project not found"
        })

      {:no_state, _} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{
          message: "State not found"
        })

      {:state_found, state} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, state.value)
    end
  end

  @doc """
  Delete State Endpoint
  """
  def delete(conn, _params) do
    body = Jason.encode!(%{status: "ok"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
