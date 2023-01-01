# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Raccoon.Context.EnvironmentContextTest do
  @moduledoc """
  Environment Context Test Cases
  """
  use Raccoon.DataCase

  alias Raccoon.Context.EnvironmentContext
  alias Raccoon.Context.ProjectContext
  alias Raccoon.Context.TeamContext

  describe "new_env/1" do
    test "returns a new environment with a UUID" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      env =
        EnvironmentContext.new_env(%{
          slug: "foo",
          name: "bar",
          username: "baz",
          secret: "qux",
          project_id: project.id
        })

      assert env.slug == "foo"
      assert env.name == "bar"
      assert env.username == "baz"
      assert env.secret == "qux"
      assert env.project_id == project.id
      assert is_binary(env.uuid)
    end
  end

  describe "create_env/1" do
    test "creates a new environment" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      assert env.slug == "foo"
      assert env.name == "bar"
      assert env.username == "baz"
      assert env.secret == "qux"
      assert env.project_id == project.id
      assert is_binary(env.uuid)
    end
  end

  describe "get_env_by_id/1" do
    test "returns the environment with the given ID" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      result = EnvironmentContext.get_env_by_id(env.id)

      assert result == env
    end
  end

  describe "get_env_by_slug/1" do
    test "returns the environment with the given slug" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      result = EnvironmentContext.get_env_by_slug("foo")

      assert result == env
    end
  end

  describe "get_env_by_uuid/1" do
    test "returns the environment with the given UUID" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      result = EnvironmentContext.get_env_by_uuid(env.uuid)

      assert result == env
    end
  end

  describe "update_env/2" do
    test "updates the environment with the given attributes" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      updated_attrs = %{
        slug: "baz",
        name: "qux",
        username: "foo",
        secret: "bar",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, updated_env} = EnvironmentContext.update_env(env, updated_attrs)

      assert updated_env.slug == "baz"
      assert updated_env.name == "qux"
      assert updated_env.username == "foo"
      assert updated_env.secret == "bar"
      assert updated_env.project_id == project.id
      assert updated_env.uuid == env.uuid
    end
  end

  describe "delete_env/1" do
    test "deletes the given environment" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      EnvironmentContext.delete_env(env)

      assert EnvironmentContext.get_env_by_id(env.id) == nil
    end
  end

  describe "create_env_meta/1" do
    test "creates a new environment meta" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      attrs = %{
        key: "foo",
        value: "bar",
        environment_id: env.id
      }

      {:ok, env_meta} = EnvironmentContext.create_env_meta(attrs)

      assert env_meta.key == "foo"
      assert env_meta.value == "bar"
      assert env_meta.environment_id == env.id
    end
  end

  describe "get_env_meta_by_id/1" do
    test "returns the environment meta with the given ID" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      attrs = %{key: "foo", value: "bar", environment_id: env.id}

      {:ok, env_meta} = EnvironmentContext.create_env_meta(attrs)

      result = EnvironmentContext.get_env_meta_by_id(env_meta.id)

      assert result == env_meta
    end
  end

  describe "update_env_meta/2" do
    test "updates the environment meta with the given attributes" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      attrs = %{
        key: "foo",
        value: "bar",
        environment_id: env.id
      }

      {:ok, env_meta} = EnvironmentContext.create_env_meta(attrs)

      updated_attrs = %{
        key: "baz",
        value: "qux"
      }

      {:ok, updated_env_meta} = EnvironmentContext.update_env_meta(env_meta, updated_attrs)

      assert updated_env_meta.key == "baz"
      assert updated_env_meta.value == "qux"
      assert updated_env_meta.environment_id == env_meta.environment_id
    end
  end

  describe "delete_env_meta/1" do
    test "deletes the given environment meta" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      attrs = %{
        key: "foo",
        value: "bar",
        environment_id: env.id
      }

      {:ok, env_meta} = EnvironmentContext.create_env_meta(attrs)

      EnvironmentContext.delete_env_meta(env_meta)

      assert EnvironmentContext.get_env_meta_by_id(env_meta.id) == nil
    end
  end

  describe "get_env_meta_by_id_key/2" do
    test "returns the environment meta with the given environment ID and key" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      attrs = %{
        key: "foo",
        value: "bar",
        environment_id: env.id
      }

      {:ok, env_meta} = EnvironmentContext.create_env_meta(attrs)

      result = EnvironmentContext.get_env_meta_by_id_key(env.id, "foo")

      assert result == env_meta
    end
  end

  describe "get_env_metas/1" do
    test "returns all environment metas for the given environment ID" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project_item =
        ProjectContext.new_project(%{
          name: "Raccoon",
          description: "Raccoon Project",
          slug: "raccoon",
          team_id: team.id
        })

      {:ok, project} = ProjectContext.create_project(project_item)

      attrs = %{
        slug: "foo",
        name: "bar",
        username: "baz",
        secret: "qux",
        project_id: project.id,
        uuid: "e101c54b-2065-4694-9126-772739065c49"
      }

      {:ok, env} = EnvironmentContext.create_env(attrs)

      attrs1 = %{
        key: "foo",
        value: "bar",
        environment_id: env.id
      }

      attrs2 = %{
        key: "baz",
        value: "qux",
        environment_id: env.id
      }

      {:ok, env_meta1} = EnvironmentContext.create_env_meta(attrs1)
      {:ok, env_meta2} = EnvironmentContext.create_env_meta(attrs2)

      result = EnvironmentContext.get_env_metas(env.id)

      assert result == [env_meta1, env_meta2]
    end
  end
end
