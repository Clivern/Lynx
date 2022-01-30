# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule PardWeb.LockController do
  @moduledoc """
  Lock Controller
  """

  use PardWeb, :controller
  alias Pard.Module.LockModule
  alias Pard.Module.ProjectModule
  alias Pard.Service.ValidatorService

  plug :auth

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
  Lock Endpoint
  """
  def lock(conn, params) do
    is_locked =
      LockModule.is_locked(%{
        project: ValidatorService.get_str(params["project"], ""),
        environment: ValidatorService.get_str(params["environment"], "")
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

      :success ->
        action =
          LockModule.lock_action(%{
            project: ValidatorService.get_str(params["project"], ""),
            environment: ValidatorService.get_str(params["environment"], ""),
            tf_uuid: ValidatorService.get_str(params["ID"], ""),
            tf_operation: ValidatorService.get_str(params["Operation"], ""),
            tf_info: ValidatorService.get_str(params["Info"], ""),
            tf_who: ValidatorService.get_str(params["Who"], ""),
            tf_version: ValidatorService.get_str(params["Version"], ""),
            tf_path: ValidatorService.get_str(params["Path"], "")
          })

        case action do
          :success ->
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
        project: ValidatorService.get_str(params["project"], ""),
        environment: ValidatorService.get_str(params["environment"], "")
      })

    case action do
      :success ->
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
