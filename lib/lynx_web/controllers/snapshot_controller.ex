# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.SnapshotController do
  @moduledoc """
  Snapshot Controller
  """

  use LynxWeb, :controller

  require Logger

  alias Lynx.Module.SnapshotModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Module.PermissionModule

  @title_min_length 2
  @title_max_length 60
  @description_min_length 2
  @description_max_length 250

  @default_list_limit 10
  @default_list_offset 0

  plug :regular_user when action in [:list, :index, :create, :delete, :restore]
  plug :access_check when action in [:index, :delete, :restore]

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
         conn.params[:uuid],
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
    limit = params[:limit] || @default_list_limit
    offset = params[:offset] || @default_list_offset

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
    case validate_create_request(params) do
      {:ok, _} ->
        {data, status} =
          case SnapshotModule.take_snapshot(params[:record_type], params[:record_uuid]) do
            {:error, msg} ->
              Logger.info("Snapshot failed with error: #{msg}")
              {"", "failure"}

            {:ok, data} ->
              {data, "success"}
          end

        result =
          SnapshotModule.create_snapshot(%{
            title: params[:title],
            description: params[:description],
            record_type: params[:record_type],
            record_uuid: params[:record_uuid],
            status: status,
            data: data,
            team_id: params[:team_id]
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

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
    end
  end

  @doc """
  Update Snapshot Endpoint
  """
  def update(conn, params) do
    case validate_update_request(params) do
      {:ok, _} ->
        result =
          SnapshotModule.update_snapshot(%{
            uuid: params[:uuid],
            title: params[:title],
            description: params[:description],
            team_id: params[:team_id]
          })

        case result do
          {:ok, snapshot} ->
            conn
            |> put_status(:ok)
            |> render("index.json", %{snapshot: snapshot})

          {:error, msg} ->
            conn
            |> put_status(:bad_request)
            |> render("error.json", %{message: msg})
        end

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
    end
  end

  @doc """
  Index Snapshot Endpoint
  """
  def index(conn, %{:uuid => uuid}) do
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
  def delete(conn, %{:uuid => uuid}) do
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

  @doc """
  Restore Snapshot Endpoint
  """
  def restore(conn, %{:uuid => uuid}) do
    case SnapshotModule.restore_snapshot(uuid) do
      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: msg})

      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> render("restore.json", %{message: "Snapshot restored successfully!"})
    end
  end

  defp validate_create_request(params) do
    errs = %{
      title_required: "Snapshot title is required",
      title_invalid: "Snapshot title is invalid",
      description_required: "Snapshot description is required",
      description_invalid: "Snapshot description is invalid",
      record_type_required: "Record type is required",
      record_type_invalid: "Record type is invalid",
      record_uuid_required: "Record ID is required",
      record_uuid_invalid: "Record ID is invalid",
      team_id_required: "Team is required"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["title"], errs.title_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["description"], errs.description_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["record_type"], errs.record_type_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["record_uuid"], errs.record_uuid_required),
         {:ok, _} <- ValidatorService.is_string?(params["team_id"], errs.team_id_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["title"], errs.title_invalid),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params["description"], errs.description_invalid),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params["record_type"], errs.record_type_invalid),
         {:ok, _} <- ValidatorService.is_uuid?(params["record_uuid"], errs.record_uuid_invalid),
         {:ok, _} <- ValidatorService.is_uuid?(params["team_id"], errs.team_id_required),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["title"],
             @title_min_length,
             @title_max_length,
             errs.title_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["description"],
             @description_min_length,
             @description_max_length,
             errs.description_invalid
           ),
         {:ok, _} <-
           ValidatorService.in?(
             params["record_type"],
             ["project", "environment"],
             errs.record_type_invalid
           ) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp validate_update_request(params) do
    errs = %{
      snapshot_id_invalid: "Snapshot ID is invalid",
      title_required: "Snapshot title is required",
      title_invalid: "Snapshot title is invalid",
      description_required: "Snapshot description is required",
      description_invalid: "Snapshot description is invalid",
      team_id_required: "Team is required"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["uuid"], errs.snapshot_id_invalid),
         {:ok, _} <- ValidatorService.is_uuid?(params["uuid"], errs.snapshot_id_invalid),
         {:ok, _} <- ValidatorService.is_string?(params["title"], errs.title_required),
         {:ok, _} <- ValidatorService.is_string?(params["team_id"], errs.team_id_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["description"], errs.description_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["title"], errs.title_invalid),
         {:ok, _} <- ValidatorService.is_uuid?(params["team_id"], errs.team_id_required),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params["description"], errs.description_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["title"],
             @title_min_length,
             @title_max_length,
             errs.title_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["description"],
             @description_min_length,
             @description_max_length,
             errs.description_invalid
           ) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
