defmodule Raccoon.Context.TeamContextTest do
  use ExUnit.Case

  alias Raccoon.Context.TeamContext

  describe "new_team/1" do
    test "returns a new team" do
      team = TeamContext.new_team(%{slug: "team-1", name: "Team 1", description: "Description 1"})

      assert team.slug == "team-1"
      assert team.name == "Team 1"
      assert team.description == "Description 1"
      assert is_binary(team.uuid)
    end
  end

  describe "create_team/1" do
    test "creates a new team" do
      attrs = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      team = TeamContext.create_team(attrs)

      assert team.slug == "team-1"
      assert team.name == "Team 1"
      assert team.description == "Description 1"
      assert is_binary(team.uuid)
    end
  end

  describe "get_team_by_id/1" do
    test "returns the team with the given ID" do
      attrs = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      team = TeamContext.create_team(attrs)

      result = TeamContext.get_team_by_id(team.id)

      assert result == team
    end
  end

  describe "get_team_by_uuid/1" do
    test "returns the team with the given UUID" do
      attrs = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      team = TeamContext.create_team(attrs)

      result = TeamContext.get_team_by_uuid(team.uuid)

      assert result == team
    end
  end

  describe "get_team_by_slug/1" do
    test "returns the team with the given slug" do
      attrs = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      team = TeamContext.create_team(attrs)

      result = TeamContext.get_team_by_slug(team.slug)

      assert result == team
    end
  end

  describe "update_team/2" do
    test "updates the team with the given attributes" do
      attrs = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      team = TeamContext.create_team(attrs)

      updated_attrs = %{slug: "team-2", name: "Team 2", description: "Description 2"}
      updated_team = TeamContext.update_team(team, updated_attrs)

      assert updated_team.slug == "team-2"
      assert updated_team.name == "Team 2"
      assert updated_team.description == "Description 2"
      assert updated_team.uuid == team.uuid
    end
  end

  describe "delete_team/1" do
    test "deletes the given team" do
      attrs = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      team = TeamContext.create_team(attrs)

      TeamContext.delete_team(team)

      assert TeamContext.get_team_by_id(team.id) == nil
    end
  end

  describe "get_teams/0" do
    test "returns all teams" do
      attrs1 = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      attrs2 = %{slug: "team-2", name: "Team 2", description: "Description 2"}
      team1 = TeamContext.create_team(attrs1)
      team2 = TeamContext.create_team(attrs2)

      result = TeamContext.get_teams()

      assert result == [team1, team2]
    end
  end

  describe "get_teams/2" do
    test "returns the teams with the given offset and limit" do
      attrs1 = %{slug: "team-1", name: "Team 1", description: "Description 1"}
      attrs2 = %{slug: "team-2", name: "Team 2", description: "Description 2"}
      attrs3 = %{slug: "team-3", name: "Team 3", description: "Description 3"}
      team1 = TeamContext.create_team(attrs1)
      team2 = TeamContext.create_team(attrs2)
      team3 = TeamContext.create_team(attrs3)

      result = TeamContext.get_teams(1, 1)

      assert result == [team2]
    end
  end

  describe "create_team_meta/1" do
    test "creates a new team meta" do
      attrs = %{key: "foo", value: "bar", team_id: 1}
      team_meta = TeamContext.create_team_meta(attrs)

      assert team_meta.key == "foo"
      assert team_meta.value == "bar"
      assert team_meta.team_id == 1
    end
  end

  describe "get_team_meta_by_id/1" do
    test "returns the team meta with the given ID" do
      attrs = %{key: "foo", value: "bar", team_id: 1}
      team_meta = TeamContext.create_team_meta(attrs)

      result = TeamContext.get_team_meta_by_id(team_meta.id)

      assert result == team_meta
    end
  end

  describe "update_team_meta/2" do
    test "updates the team meta with the given attributes" do
      attrs = %{key: "foo", value: "bar", team_id: 1}
      team_meta = TeamContext.create_team_meta(attrs)

      updated_attrs = %{key: "baz", value: "qux", team_id: 2}
      updated_team_meta = TeamContext.update_team_meta(team_meta, updated_attrs)

      assert updated_team_meta.key == "baz"
      assert updated_team_meta.value == "qux"
      assert updated_team_meta.team_id == 2
    end
  end

  describe "delete_team_meta/1" do
    test "deletes the given team meta" do
      attrs = %{key: "foo", value: "bar", team_id: 1}
      team_meta = TeamContext.create_team_meta(attrs)

      TeamContext.delete_team_meta(team_meta)

      assert TeamContext.get_team_meta_by_id(team_meta.id) == nil
    end
  end
end
