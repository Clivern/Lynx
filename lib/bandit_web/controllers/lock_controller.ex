# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.LockController do
  @moduledoc """
  Lock Controller
  """

  use BanditWeb, :controller

  require Logger

  alias Bandit.Module.LockModule
  alias Bandit.Module.EnvironmentModule
  alias Bandit.Service.ValidatorService

  plug :auth, only: [:lock, :unlock]

  defp auth(conn, _opts) do
    with {user, secret} <- Plug.BasicAuth.parse_basic_auth(conn) do
      result =
        EnvironmentModule.is_access_allowed(%{
          team_slug: conn.params["t_slug"],
          project_slug: conn.params["p_slug"],
          env_slug: conn.params["e_slug"],
          username: user,
          secret: secret
        })

      case result do
        {:error, msg} ->
          Logger.info(msg)

          conn
          |> put_status(:forbidden)
          |> render("error.json", %{
            message: "Access is forbidden"
          })

        {:ok, _} ->
          conn
      end
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end

  @doc """
  Lock Endpoint
  """
  def lock(conn, params) do
    is_locked =
      LockModule.is_locked(%{
        t_slug: ValidatorService.get_str(params["t_slug"], ""),
        p_slug: ValidatorService.get_str(params["p_slug"], ""),
        e_slug: ValidatorService.get_str(params["e_slug"], "")
      })

    case is_locked do
      {:locked, lock} ->
        conn
        |> put_status(:locked)
        |> render("lock_data.json", %{
          lock: lock
        })

      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{
          message: msg
        })

      {:success, _} ->
        action =
          LockModule.lock_action(%{
            t_slug: ValidatorService.get_str(params["t_slug"], ""),
            p_slug: ValidatorService.get_str(params["p_slug"], ""),
            e_slug: ValidatorService.get_str(params["e_slug"], ""),
            uuid: ValidatorService.get_str(params["ID"], ""),
            operation: ValidatorService.get_str(params["Operation"], ""),
            info: ValidatorService.get_str(params["Info"], ""),
            who: ValidatorService.get_str(params["Who"], ""),
            version: ValidatorService.get_str(params["Version"], ""),
            path: ValidatorService.get_str(params["Path"], "")
          })

        case action do
          {:success, ""} ->
            conn
            |> put_status(:ok)
            |> render("lock.json", %{})

          {:not_found, msg} ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{
              message: msg
            })

          {:error, msg} ->
            conn
            |> put_status(:internal_server_error)
            |> render("error.json", %{
              message: msg
            })
        end
    end
  end

  @doc """
  Unlock Endpoint
  """
  def unlock(conn, params) do
    action =
      LockModule.unlock_action(%{
        t_slug: ValidatorService.get_str(params["t_slug"], ""),
        p_slug: ValidatorService.get_str(params["p_slug"], ""),
        e_slug: ValidatorService.get_str(params["e_slug"], "")
      })

    case action do
      {:success, ""} ->
        conn
        |> put_status(:ok)
        |> render("unlock.json", %{})

      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{
          message: msg
        })

      {:error, msg} ->
        conn
        |> put_status(:internal_server_error)
        |> render("error.json", %{
          message: msg
        })
    end
  end
end
