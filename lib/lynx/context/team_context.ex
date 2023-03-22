# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Context.TeamContext do
  @moduledoc """
  Team Context Module
  """

  import Ecto.Query

  alias Lynx.Repo
  alias Lynx.Model.{Team, TeamMeta}

  @doc """
  Get a new team
  """
  def new_team(attrs \\ %{}) do
    %{
      name: attrs.name,
      description: attrs.description,
      slug: attrs.slug,
      uuid: Map.get(attrs, :uuid, Ecto.UUID.generate())
    }
  end

  @doc """
  Get a team meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      team_id: meta.team_id
    }
  end

  @doc """
  Create a new team
  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get Team ID with UUID
  """
  def get_team_id_with_uuid(uuid) do
    case get_team_by_uuid(uuid) do
      nil ->
        nil

      team ->
        team.id
    end
  end

  @doc """
  Get Team UUID with ID
  """
  def get_team_uuid_with_id(id) do
    case get_team_by_id(id) do
      nil ->
        nil

      team ->
        team.uuid
    end
  end

  @doc """
  Retrieve a team by ID
  """
  def get_team_by_id(id) do
    Repo.get(Team, id)
  end

  @doc """
  Validate Team ID
  """
  def validate_team_id(id) do
    case get_team_by_id(id) do
      nil ->
        false

      _ ->
        true
    end
  end

  @doc """
  Validate Team UUID
  """
  def validate_team_uuid(uuid) do
    case get_team_by_uuid(uuid) do
      nil ->
        false

      _ ->
        true
    end
  end

  @doc """
  Get team by uuid
  """
  def get_team_by_uuid(uuid) do
    from(
      t in Team,
      where: t.uuid == ^uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Get team by slug
  """
  def get_team_by_slug(slug) do
    from(
      t in Team,
      where: t.slug == ^slug
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Update a team
  """
  def update_team(team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a team
  """
  def delete_team(team) do
    Repo.delete(team)
  end

  @doc """
  Retrieve all teams
  """
  def get_teams() do
    Repo.all(Team)
  end

  @doc """
  Retrieve teams
  """
  def get_teams(offset, limit) do
    from(t in Team,
      order_by: [desc: t.inserted_at],
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Retrieve teams
  """
  def get_teams(teams_ids, offset, limit) do
    from(t in Team,
      order_by: [desc: t.inserted_at],
      where: t.id in ^teams_ids,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Count all teams
  """
  def count_teams() do
    from(t in Team,
      select: count(t.id)
    )
    |> Repo.one()
  end

  @doc """
  Create a new team meta
  """
  def create_team_meta(attrs \\ %{}) do
    %TeamMeta{}
    |> TeamMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a team meta by id
  """
  def get_team_meta_by_id(id) do
    Repo.get(TeamMeta, id)
  end

  @doc """
  Update a team meta
  """
  def update_team_meta(team_meta, attrs) do
    team_meta
    |> TeamMeta.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a team meta
  """
  def delete_team_meta(team_meta) do
    Repo.delete(team_meta)
  end

  @doc """
  Get team meta by team id and key
  """
  def get_team_meta_by_id_key(team_id, meta_key) do
    from(
      t in TeamMeta,
      where: t.team_id == ^team_id,
      where: t.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get team metas
  """
  def get_team_metas(team_id) do
    from(
      t in TeamMeta,
      where: t.team_id == ^team_id
    )
    |> Repo.all()
  end
end
