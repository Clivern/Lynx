# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.TeamController do
  @moduledoc """
  Team Controller
  """

  use LynxWeb, :controller

  alias Lynx.Module.TeamModule
  alias Lynx.Service.ValidatorService
  alias Lynx.Exception.InvalidRequest

  require Logger

  @default_list_limit "10"
  @default_list_offset "0"

  plug :regular_user when action in [:list]
  plug :super_user when action in [:index, :create, :update, :delete]

  defp super_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_super] do
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
  List Action Endpoint
  """
  def list(conn, params) do
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)

    {teams, count} =
      if conn.assigns[:is_super] do
        {TeamModule.get_teams(offset, limit), TeamModule.count_teams()}
      else
        {TeamModule.get_teams(conn.assigns[:user_id], offset, limit),
         TeamModule.count_teams(conn.assigns[:user_id])}
      end

    render(conn, "list.json", %{
      teams: teams,
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: count
      }
    })
  end

  @doc """
  Create Action Endpoint
  """
  def create(conn, params) do
    try do
      validate_create_request(params)

      slug = ValidatorService.get_str(params["slug"], "")

      # Validate if slug is used before
      if TeamModule.is_slug_used(slug) do
        raise InvalidRequest, message: "Team slug is used"
      end

      members = ValidatorService.get_list(params["members"], [])

      result =
        TeamModule.create_team(%{
          slug: slug,
          name: ValidatorService.get_str(params["name"], ""),
          description: ValidatorService.get_str(params["description"], "")
        })

      case result do
        {:ok, team} ->
          TeamModule.sync_team_members(team.id, members)

          conn
          |> put_status(:created)
          |> render("index.json", %{team: team})

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
  Index Action Endpoint
  """
  def index(conn, %{"uuid" => uuid}) do
    case TeamModule.get_team_by_uuid(uuid) do
      {:not_found, msg} ->
        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

      {:ok, team} ->
        conn
        |> put_status(:ok)
        |> render("index.json", %{team: team})
    end
  end

  @doc """
  Update Action Endpoint
  """
  def update(conn, params) do
    try do
      validate_update_request(params)

      members = ValidatorService.get_list(params["members"], [])

      result =
        TeamModule.update_team(%{
          uuid: ValidatorService.get_str(params["uuid"], ""),
          name: ValidatorService.get_str(params["name"], ""),
          description: ValidatorService.get_str(params["description"], "")
        })

      case result do
        {:ok, team} ->
          TeamModule.sync_team_members(team.id, members)

          conn
          |> put_status(:ok)
          |> render("index.json", %{team: team})

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
    else
      _ ->
        conn
        |> put_status(:ok)
        |> render("success.json", %{message: "Team updated successfully"})
    end
  end

  @doc """
  Delete Action Endpoint
  """
  def delete(conn, %{"uuid" => uuid}) do
    Logger.info("Attempt to delete team with uuid #{uuid}")

    case TeamModule.delete_team_by_uuid(uuid) do
      {:not_found, msg} ->
        Logger.info("Team with uuid #{uuid} not found")

        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: msg})

      {:ok, _} ->
        Logger.info("Team with uuid #{uuid} is deleted")

        conn
        |> send_resp(:no_content, "")
    end
  end

  defp validate_create_request(params) do
    errs = %{
      name_required: "Team name is required",
      name_invalid: "Team name is invalid",
      description_required: "Team description is required",
      description_invalid: "Team description is invalid",
      slug_required: "Team slug is required",
      slug_invalid: "Team slug is invalid",
      slug_used: "Team slug is already used",
      members_invalid: "Team members are required"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["description"], errs.description_required),
         {:ok, _} <- ValidatorService.is_string?(params["slug"], errs.slug_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params["description"], errs.description_invalid),
         {:ok, _} <- ValidatorService.is_not_empty?(params["slug"], errs.slug_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["name"], 2, 60, errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["description"],
             2,
             250,
             errs.description_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["slug"], 2, 60, errs.slug_invalid),
         {:ok, _} <- ValidatorService.is_team_slug_used?(params["slug"], nil, errs.slug_used),
         {:ok, _} <- ValidatorService.is_list?(params["members"], errs.members_invalid),
         {:ok, _} <- ValidatorService.is_not_empty_list?(params["members"], errs.members_invalid) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp validate_update_request(params, team_uuid) do
    errs = %{
      name_required: "Team name is required",
      name_invalid: "Team name is invalid",
      description_required: "Team description is required",
      description_invalid: "Team description is invalid",
      slug_required: "Team slug is required",
      slug_invalid: "Team slug is invalid",
      slug_used: "Team slug is already used",
      members_invalid: "Team members are required"
    }

    with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
         {:ok, _} <-
           ValidatorService.is_string?(params["description"], errs.description_required),
         {:ok, _} <- ValidatorService.is_string?(params["slug"], errs.slug_required),
         {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_not_empty?(params["description"], errs.description_invalid),
         {:ok, _} <- ValidatorService.is_not_empty?(params["slug"], errs.slug_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["name"], 2, 60, errs.name_invalid),
         {:ok, _} <-
           ValidatorService.is_length_between?(
             params["description"],
             2,
             250,
             errs.description_invalid
           ),
         {:ok, _} <-
           ValidatorService.is_length_between?(params["slug"], 2, 60, errs.slug_invalid),
         {:ok, _} <-
           ValidatorService.is_team_slug_used?(params["slug"], team_uuid, errs.slug_used),
         {:ok, _} <- ValidatorService.is_list?(params["members"], errs.members_invalid),
         {:ok, _} <- ValidatorService.is_not_empty_list?(params["members"], errs.members_invalid) do
      {:ok, ""}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
