# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Brangus.Context.TeamContext do
  @moduledoc """
  Team Context Module
  """

  import Ecto.Query
  alias Brangus.Repo
  alias Brangus.Model.{Team, TeamMeta}

  @doc """
  Get a new team
  """
  def new_team(team \\ %{}) do
    %{
      slug: team.slug,
      name: team.name,
      description: team.description,
      uuid: Ecto.UUID.generate()
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
  Retrieve a team by ID
  """
  def get_team_by_id(id) do
    Repo.get(Team, id)
  end

  @doc """
  Get team by uuid
  """
  def get_team_by_uuid(uuid) do
    from(
      u in Team,
      where: u.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Get team by slug
  """
  def get_team_by_slug(slug) do
    from(
      u in Team,
      where: u.slug == ^slug
    )
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
    from(u in Team,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
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
      u in TeamMeta,
      where: u.team_id == ^team_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get team metas
  """
  def get_team_metas(team_id) do
    from(
      u in TeamMeta,
      where: u.team_id == ^team_id
    )
    |> Repo.all()
  end
end
