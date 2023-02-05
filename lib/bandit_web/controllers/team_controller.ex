# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.TeamController do
  @moduledoc """
  Team Controller
  """

  use BanditWeb, :controller

  alias Bandit.Module.TeamModule
  alias Bandit.Service.ValidatorService
  alias Bandit.Exception.InvalidRequest

  require Logger

  @default_list_limit "10"
  @default_list_offset "0"

  plug :super_user, only: [:list, :index, :create, :update, :delete]

  defp super_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_super] do
      Logger.info("User doesn't have the right access permissions")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
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

    render(conn, "list.json", %{
      users: TeamModule.get_teams(offset, limit),
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: TeamModule.count_teams()
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

      result =
        TeamModule.create_team(%{
          slug: slug,
          name: ValidatorService.get_str(params["name"], ""),
          description: ValidatorService.get_str(params["description"], "")
        })

      case result do
        {:ok, team} ->
          conn
          |> put_status(:created)
          |> render("index.json", %{team: team})

        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{error: msg})
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
        |> render("success.json", %{message: "User created successfully"})
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
        |> render("error.json", %{error: msg})

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

      result =
        TeamModule.update_team(%{
          uuid: ValidatorService.get_str(params["uuid"], ""),
          name: ValidatorService.get_str(params["name"], ""),
          description: ValidatorService.get_str(params["description"], "")
        })

      case result do
        {:ok, team} ->
          conn
          |> put_status(:ok)
          |> render("index.json", %{team: team})

        {:error, msg} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", %{error: msg})
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
        conn
        |> put_status(:not_found)
        |> render("error.json", %{error: msg})

      {:ok, _} ->
        conn
        |> send_resp(:no_content, "")
    end
  end

  defp validate_create_request(params) do
    name = ValidatorService.get_str(params["name"], "")
    description = ValidatorService.get_str(params["description"], "")
    slug = ValidatorService.get_str(params["slug"], "")

    if ValidatorService.is_empty(name) do
      raise InvalidRequest, message: "Team name is required"
    end

    if ValidatorService.is_empty(description) do
      raise InvalidRequest, message: "Team description is required"
    end

    if ValidatorService.is_empty(slug) do
      raise InvalidRequest, message: "Team slug is required"
    end
  end

  defp validate_update_request(params) do
    name = ValidatorService.get_str(params["name"], "")
    description = ValidatorService.get_str(params["description"], "")

    if ValidatorService.is_empty(name) do
      raise InvalidRequest, message: "Team name is required"
    end

    if ValidatorService.is_empty(description) do
      raise InvalidRequest, message: "Team description is required"
    end
  end
end
