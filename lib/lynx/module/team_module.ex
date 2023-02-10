# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.TeamModule do
  @moduledoc """
  Team Module
  """

  alias Lynx.Context.TeamContext
  alias Lynx.Context.UserContext
  alias Lynx.Service.ValidatorService

  @doc """
  Create a team
  """
  def create_team(data \\ %{}) do
    team =
      TeamContext.new_team(%{
        name: data[:name],
        slug: data[:slug],
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
  Sync team members
  """
  def sync_team_members(team_id, future_members \\ []) do
    current_members = []

    current_members =
      for member <- UserContext.get_team_users(team_id) do
        current_members ++ member.id
      end

    future_members_ids = []

    future_members_ids =
      for member <- future_members do
        future_members_ids ++ get_user_id_with_uuid(member)
      end

    # @TODO: Track errors
    for member <- current_members do
      if member not in future_members_ids do
        UserContext.remove_user_from_team(member, team_id)
      end
    end

    for member <- future_members_ids do
      if member not in current_members do
        UserContext.add_user_to_team(member, team_id)
      end
    end
  end

  @doc """
  Update a team
  """
  def update_team(data \\ %{}) do
    uuid = ValidatorService.get_str(data[:uuid], "")

    case TeamContext.get_team_by_uuid(uuid) do
      nil ->
        {:not_found, "Team with UUID #{uuid} not found"}

      team ->
        new_team =
          TeamContext.new_team(%{
            name: ValidatorService.get_str(data[:name], team.name),
            description: ValidatorService.get_str(data[:description], team.description),
            slug: team.slug
          })

        case TeamContext.update_team(team, new_team) do
          {:ok, team} ->
            {:ok, team}

          {:error, changeset} ->
            messages =
              changeset.errors()
              |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

            {:error, Enum.at(messages, 0)}
        end
    end
  end

  @doc """
  Get team by an id
  """
  def get_team_by_id(id) do
    case TeamContext.get_team_by_id(id) do
      nil ->
        {:not_found, "Team with ID #{id} not found"}

      team ->
        {:ok, team}
    end
  end

  @doc """
  Get team by UUID
  """
  def get_team_by_uuid(uuid) do
    case TeamContext.get_team_by_uuid(uuid) do
      nil ->
        {:not_found, "Team with UUID #{uuid} not found"}

      team ->
        {:ok, team}
    end
  end

  @doc """
  Get team by slug
  """
  def is_slug_used(slug) do
    slug = ValidatorService.get_str(slug, "")

    team = slug |> TeamContext.get_team_by_slug()

    case team do
      nil ->
        false

      _ ->
        true
    end
  end

  @doc """
  Count Teams
  """
  def count_teams() do
    TeamContext.count_teams()
  end

  @doc """
  Count Teams
  """
  def count_teams(user_id) do
    length(get_user_teams(user_id))
  end

  @doc """
  Get user teams
  """
  def get_user_teams(user_id) do
    UserContext.get_user_teams(user_id)
  end

  @doc """
  Get teams
  """
  def get_teams(offset, limit) do
    TeamContext.get_teams(offset, limit)
  end

  @doc """
  Get teams
  """
  def get_teams(user_id, offset, limit) do
    user_teams = get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    TeamContext.get_teams(teams_ids, offset, limit)
  end

  @doc """
  Delete a Team by UUID
  """
  def delete_team_by_uuid(uuid) do
    case TeamContext.get_team_by_uuid(uuid) do
      nil ->
        {:not_found, "Team with ID #{uuid} not found"}

      team ->
        TeamContext.delete_team(team)
        {:ok, "Team with ID #{uuid} deleted successfully"}
    end
  end

  @doc """
  Validate Team ID
  """
  def validate_team_id(id) do
    TeamContext.validate_team_id(id)
  end

  @doc """
  Validate Team UUID
  """
  def validate_team_uuid(uuid) do
    TeamContext.validate_team_uuid(uuid)
  end

  @doc """
  Get Team ID with UUID
  """
  def get_team_id_with_uuid(uuid) do
    TeamContext.get_team_id_with_uuid(uuid)
  end

  def get_team_uuid_with_id(id) do
    TeamContext.get_team_uuid_with_id(id)
  end

  def get_user_id_with_uuid(uuid) do
    UserContext.get_user_id_with_uuid(uuid)
  end
end
