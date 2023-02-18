# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.SnapshotController do
  @moduledoc """
  Snapshot Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Exception.InvalidRequest
  alias Lynx.Module.SnapshotModule
  alias Lynx.Module.TeamModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Module.PermissionModule

  @default_list_limit "10"
  @default_list_offset "0"

  plug :regular_user when action in [:list, :index, :create, :delete]
  plug :access_check when action in [:index, :delete]

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

  defp access_check(conn, _opts) do
    Logger.info("Validate if user can access snapshot")

    if not PermissionModule.can_access_snapshot_uuid(
         :snapshot,
         conn.assigns[:user_role],
         conn.params["uuid"],
         conn.assigns[:user_id]
       ) do
      Logger.info("User doesn't own the snapshot")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
      |> halt
    else
      Logger.info("User can access the snapshot")

      conn
    end
  end

  @doc """
  List Snapshots Endpoint
  """
  def list(conn, params) do
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)

    {snapshots, count} =
      if conn.assigns[:is_super] do
        {SnapshotModule.get_snapshots(offset, limit), SnapshotModule.count_snapshots()}
      else
        {SnapshotModule.get_snapshots(conn.assigns[:user_id], offset, limit),
         SnapshotModule.count_snapshots(conn.assigns[:user_id])}
      end

    render(conn, "list.json", %{
      snapshots: snapshots,
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: count
      }
    })
  end

  @doc """
  Create Snapshot Endpoint
  """
  def create(conn, params) do
    try do
      validate_create_request(params)

      team_id = TeamModule.get_team_id_with_uuid(ValidatorService.get_str(params["team_id"], ""))

      result =
        SnapshotModule.create_snapshot(%{
          title: ValidatorService.get_str(params["title"], ""),
          description: ValidatorService.get_str(params["description"], ""),
          record_type: ValidatorService.get_str(params["record_type"], ""),
          record_uuid: ValidatorService.get_str(params["record_uuid"], ""),
          status: "unknown",
          data: "{}",
          team_id: team_id
        })

      case result do
        {:ok, snapshot} ->
          conn
          |> put_status(:created)
          |> render("index.json", %{snapshot: snapshot})

        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{message: msg})
      end
    rescue
      e in InvalidRequest ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: e.message})

      _ ->
        conn
        |> put_status(:internal_server_error)
        |> render("error.json", %{message: "Internal server error"})
    end
  end

  @doc """
  Index Snapshot Endpoint
  """
  def index(conn, %{"uuid" => uuid}) do
    case SnapshotModule.get_snapshot_by_uuid(uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

      {:ok, snapshot} ->
        conn
        |> put_status(:ok)
        |> render("index.json", %{snapshot: snapshot})
    end
  end

  @doc """
  Delete Snapshot Endpoint
  """
  def delete(conn, %{"uuid" => uuid}) do
    case SnapshotModule.delete_snapshot_by_uuid(uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

      {:ok, _} ->
        conn
        |> send_resp(:no_content, "")
    end
  end

  defp validate_create_request(params) do
    title = ValidatorService.get_str(params["title"], "")
    description = ValidatorService.get_str(params["description"], "")
    record_type = ValidatorService.get_str(params["record_type"], "")
    record_uuid = ValidatorService.get_str(params["record_uuid"], "")
    team_id = ValidatorService.get_str(params["team_id"], "")

    if ValidatorService.is_empty(title) do
      raise InvalidRequest, message: "Snapshot title is required"
    end

    if ValidatorService.is_empty(description) do
      raise InvalidRequest, message: "Snapshot description is required"
    end

    if ValidatorService.is_empty(record_type) do
      raise InvalidRequest, message: "Snapshot record type is required"
    end

    if ValidatorService.is_empty(record_uuid) do
      raise InvalidRequest, message: "Snapshot record ID is required"
    end

    if ValidatorService.is_empty(team_id) do
      raise InvalidRequest, message: "Team is required"
    end
  end
end
