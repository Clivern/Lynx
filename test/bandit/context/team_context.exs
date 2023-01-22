# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Context.TeamContextTest do
  @moduledoc """
  Team Context Test Cases
  """

  use ExUnit.Case

  alias Bandit.Context.TeamContext

  # Init
  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Bandit.Repo)
  end

  # Test Cases
  describe "new_team/1" do
    test "returns a new team" do
      team =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      assert team.name == "Team 1"
      assert team.description == "Description 1"
      assert is_binary(team.uuid)
    end
  end

  describe "new_meta/1" do
    test "returns a new team meta" do
      meta =
        TeamContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          team_id: 1
        })

      assert meta.key == "meta_key"
      assert meta.value == "meta_value"
      assert meta.team_id == 1
    end
  end

  describe "create_team/1" do
    test "creates a new team" do
      attrs =
        TeamContext.new_team(%{
          name: "Team 2",
          description: "Description 2",
          slug: "team-2"
        })

      {status, team} = TeamContext.create_team(attrs)

      assert status == :ok

      assert team.name == "Team 2"
      assert team.description == "Description 2"
      assert is_binary(team.uuid)
    end
  end

  describe "get_team_by_id/1" do
    test "returns the team with the given ID" do
      attrs =
        TeamContext.new_team(%{
          name: "Team 3",
          description: "Description 3",
          slug: "team-3"
        })

      {status1, team1} = TeamContext.create_team(attrs)

      assert status1 == :ok

      team2 = TeamContext.get_team_by_id(team1.id)

      assert team1 == team2
    end
  end

  describe "get_team_by_uuid/1" do
    test "returns the team with the given UUID" do
      attrs =
        TeamContext.new_team(%{
          name: "Team 4",
          description: "Description 4",
          slug: "team-4"
        })

      {status1, team1} = TeamContext.create_team(attrs)

      assert status1 == :ok

      team2 = TeamContext.get_team_by_uuid(team1.uuid)

      assert team2 == team1
    end
  end

  describe "update_team/2" do
    test "updates the team with the given attributes" do
      attrs =
        TeamContext.new_team(%{
          name: "Team 5",
          description: "Description 5",
          slug: "team-5"
        })

      {status1, team1} = TeamContext.create_team(attrs)

      assert status1 == :ok

      updated_attrs = %{name: "Team 6", description: "Description 6"}

      {status2, updated_team} = TeamContext.update_team(team1, updated_attrs)

      assert status2 == :ok
      assert updated_team.name == "Team 6"
      assert updated_team.description == "Description 6"
      assert updated_team.uuid == team1.uuid
    end
  end

  describe "delete_team/1" do
    test "deletes the given team" do
      attrs =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      {status1, team1} = TeamContext.create_team(attrs)

      assert status1 == :ok

      TeamContext.delete_team(team1)

      assert TeamContext.get_team_by_id(team1.id) == nil
    end
  end

  describe "get_teams/0" do
    test "returns all teams" do
      attrs1 =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      attrs2 =
        TeamContext.new_team(%{
          name: "Team 2",
          description: "Description 2"
        })

      {status1, team1} = TeamContext.create_team(attrs1)
      {status2, team2} = TeamContext.create_team(attrs2)

      assert status1 == :ok
      assert status2 == :ok

      result = TeamContext.get_teams()

      assert result == [team1, team2]
    end
  end

  describe "get_teams/2" do
    test "returns the teams with the given offset and limit" do
      attrs1 =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      attrs2 =
        TeamContext.new_team(%{
          name: "Team 2",
          description: "Description 2",
          slug: "team-2"
        })

      attrs3 =
        TeamContext.new_team(%{
          name: "Team 3",
          description: "Description 3",
          slug: "team-3"
        })

      {status1, _} = TeamContext.create_team(attrs1)
      {status2, team2} = TeamContext.create_team(attrs2)
      {status3, _} = TeamContext.create_team(attrs3)

      assert status1 == :ok
      assert status2 == :ok
      assert status3 == :ok

      result = TeamContext.get_teams(1, 1)

      assert result == [team2]
    end
  end

  describe "create_team_meta/1" do
    test "creates a new team meta" do
      attrs1 =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      {_, team} = TeamContext.create_team(attrs1)

      attrs =
        TeamContext.new_meta(%{
          key: "foo",
          value: "bar",
          team_id: team.id
        })

      {status, team_meta} = TeamContext.create_team_meta(attrs)

      assert status == :ok

      assert team_meta.key == "foo"
      assert team_meta.value == "bar"
      assert team_meta.team_id == team.id
    end
  end

  describe "get_team_meta_by_id/1" do
    test "returns the team meta with the given ID" do
      attrs1 =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      {_, team} = TeamContext.create_team(attrs1)

      attrs =
        TeamContext.new_meta(%{
          key: "foo",
          value: "bar",
          team_id: team.id
        })

      {status, team_meta} = TeamContext.create_team_meta(attrs)

      assert status == :ok

      result = TeamContext.get_team_meta_by_id(team_meta.id)

      assert result == team_meta
    end
  end

  describe "update_team_meta/2" do
    test "updates the team meta with the given attributes" do
      attrs1 =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      {_, team1} = TeamContext.create_team(attrs1)

      attrs =
        TeamContext.new_meta(%{
          key: "foo",
          value: "bar",
          team_id: team1.id
        })

      {_, team_meta} = TeamContext.create_team_meta(attrs)

      attrs2 =
        TeamContext.new_team(%{
          name: "Team 2",
          description: "Description 2",
          slug: "team-2"
        })

      {_, team2} = TeamContext.create_team(attrs2)

      updated_attrs =
        TeamContext.new_meta(%{
          key: "baz",
          value: "qux",
          team_id: team2.id
        })

      {_, updated_team_meta} = TeamContext.update_team_meta(team_meta, updated_attrs)

      assert updated_team_meta.key == "baz"
      assert updated_team_meta.value == "qux"
      assert updated_team_meta.team_id == team2.id
    end
  end

  describe "delete_team_meta/1" do
    test "deletes the given team meta" do
      attrs1 =
        TeamContext.new_team(%{
          name: "Team 1",
          description: "Description 1",
          slug: "team-1"
        })

      {_, team} = TeamContext.create_team(attrs1)

      attrs =
        TeamContext.new_meta(%{
          key: "foo",
          value: "bar",
          team_id: team.id
        })

      {_, team_meta} = TeamContext.create_team_meta(attrs)

      TeamContext.delete_team_meta(team_meta)

      assert TeamContext.get_team_meta_by_id(team_meta.id) == nil
    end
  end

  describe "get_team_meta_by_id_key/2" do
    test "get team meta by team id and key" do
      attrs1 =
        TeamContext.new_team(%{
          name: "team_111",
          description: "description_111",
          slug: "team_111"
        })

      {_, team} = TeamContext.create_team(attrs1)

      attrs =
        TeamContext.new_meta(%{
          key: "foo_111",
          value: "bar_111",
          team_id: team.id
        })

      {_, team_meta} = TeamContext.create_team_meta(attrs)

      result = TeamContext.get_team_meta_by_id_key(team.id, team_meta.key)

      assert result == team_meta
    end
  end

  describe "get_team_metas/1" do
    test "get all metas for a team" do
      attrs1 =
        TeamContext.new_team(%{
          name: "team_222",
          description: "description_222",
          slug: "team_222"
        })

      {_, team} = TeamContext.create_team(attrs1)

      attrs =
        TeamContext.new_meta(%{
          key: "foo_222",
          value: "bar_222",
          team_id: team.id
        })

      {_, team_meta} = TeamContext.create_team_meta(attrs)

      result = TeamContext.get_team_metas(team.id)

      assert result == [team_meta]
    end
  end
end
