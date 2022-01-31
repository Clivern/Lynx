# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Campfire.Module.TeamModule do
  @moduledoc """
  Team Module
  """

  alias Campfire.Context.TeamContext
  alias Campfire.Context.UserContext
  alias Campfire.Service.ValidatorService

  @doc """
  Create a team
  """
  def create_team(data \\ %{}) do
    team =
      TeamContext.new_team(%{
        slug: data[:slug],
        name: data[:name],
        description: data[:description]
      })

    case TeamContext.create_team(team) do
      {:ok, team} ->
        {:ok, team}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

  @doc """
  Update a team
  """
  def update_team(data \\ %{}) do
    id = data[:id]

    case ValidatorService.validate_int(id) do
      true ->
        team =
          id
          |> ValidatorService.parse_int()
          |> TeamContext.get_project_by_id()

        case team do
          nil ->
            {:not_found, "Project with ID #{id} not found"}

          _ ->
            new_team =
              TeamContext.new_team(%{
                slug: ValidatorService.get_str(data[:slug], team.slug),
                name: ValidatorService.get_str(data[:name], team.name),
                description: ValidatorService.get_str(data[:description], team.description)
              })

            case TeamContext.update_project(team, new_team) do
              {:ok, team} ->
                {:ok, team}

              {:error, changeset} ->
                messages =
                  changeset.errors()
                  |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

                {:error, Enum.at(messages, 0)}
            end
        end

      false ->
        {:error, "Invalid Project ID"}
    end
  end

  @doc """
  Get team by an id
  """
  def get_team_by_id(id) do
    case ValidatorService.validate_int(id) do
      true ->
        team =
          id
          |> ValidatorService.parse_int()
          |> TeamContext.get_team_by_id()

        case team do
          nil ->
            {:not_found, "Team with ID #{id} not found"}

          _ ->
            {:ok, team}
        end

      false ->
        {:error, "Invalid Team ID"}
    end
  end

  @doc """
  Get team by a slug
  """
  def get_team_by_slug(slug) do
    team =
      ValidatorService.get_str(slug, "")
      |> TeamContext.get_team_by_slug()

    case team do
      nil ->
        {:not_found, "Team with slug #{slug} not found"}

      _ ->
        {:ok, team}
    end
  end

  @doc """
  Get user teams
  """
  def get_teams(user_id) do
    UserContext.get_user_teams(user_id)
  end

  @doc """
  Get teams
  """
  def get_teams(offset, limit) do
    TeamContext.get_teams(offset, limit)
  end

  @doc """
  Delete A Team
  """
  def delete_team(id) do
    case ValidatorService.validate_int(id) do
      true ->
        team =
          id
          |> ValidatorService.parse_int()
          |> TeamContext.get_team_by_id()

        case team do
          nil ->
            {:not_found, "Team with ID #{id} not found"}

          _ ->
            TeamContext.delete_team(team)
            {:ok, "Team with ID #{id} deleted successfully"}
        end

      false ->
        {:error, "Invalid Team ID"}
    end
  end
end
