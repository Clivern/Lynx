# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.StateController do
  @moduledoc """
  State Controller
  """

  use BanditWeb, :controller

  alias Bandit.Module.StateModule
  alias Bandit.Service.ValidatorService
  alias Bandit.Module.ProjectModule

  plug :auth, only: [:create, :index]

  defp auth(conn, _opts) do
    with {user, pass} <- Plug.BasicAuth.parse_basic_auth(conn) do
      result =
        ProjectModule.is_allowed(%{
          project: conn.params["project"],
          environment: conn.params["environment"],
          username: user,
          secret: pass
        })

      case result do
        {:not_found, msg} ->
          conn
          |> put_status(:not_found)
          |> render("error.json", %{
            message: msg
          })
          |> halt()

        {:failed, msg} ->
          conn
          |> put_status(:forbidden)
          |> render("error.json", %{
            message: msg
          })
          |> halt()

        {:success, _} ->
          conn
      end
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end

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

      :success ->
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
end
