defmodule Raccoon.Context.ProjectContextTest do
  use ExUnit.Case

  alias Raccoon.Context.ProjectContext

  describe "new_project/1" do
    test "returns a new project" do
      team_item =
        TeamContext.new_team(%{
          slug: "raccoon",
          name: "Raccoon",
          description: "Raccoon Team"
        })

      {:ok, team} = TeamContext.create_team(team_item)

      project =
        ProjectContext.new_project(%{
          name: "Project 1",
          description: "Description 1",
          slug: "project-1",
          team_id: team.id
        })

      assert project.name == "Project 1"
      assert project.description == "Description 1"
      assert project.slug == "project-1"
      assert project.team_id == 1
      assert is_binary(project.uuid)
    end
  end

  describe "create_project/1" do
    test "creates a new project" do
      attrs = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      project = ProjectContext.create_project(attrs)

      assert project.name == "Project 1"
      assert project.description == "Description 1"
      assert project.slug == "project-1"
      assert project.team_id == 1
      assert is_binary(project.uuid)
    end
  end

  describe "get_project_by_id/1" do
    test "returns the project with the given ID" do
      attrs = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      project = ProjectContext.create_project(attrs)

      result = ProjectContext.get_project_by_id(project.id)

      assert result == project
    end
  end

  describe "get_project_by_uuid/1" do
    test "returns the project with the given UUID" do
      attrs = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      project = ProjectContext.create_project(attrs)

      result = ProjectContext.get_project_by_uuid(project.uuid)

      assert result == project
    end
  end

  describe "get_project_by_slug/1" do
    test "returns the project with the given slug" do
      attrs = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      project = ProjectContext.create_project(attrs)

      result = ProjectContext.get_project_by_slug(project.slug)

      assert result == project
    end
  end

  describe "update_project/2" do
    test "updates the project with the given attributes" do
      attrs = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      project = ProjectContext.create_project(attrs)

      updated_attrs = %{
        name: "Project 2",
        description: "Description 2",
        slug: "project-2",
        team_id: 2
      }

      updated_project = ProjectContext.update_project(project, updated_attrs)

      assert updated_project.name == "Project 2"
      assert updated_project.description == "Description 2"
      assert updated_project.slug == "project-2"
      assert updated_project.team_id == 2
      assert updated_project.uuid == project.uuid
    end
  end

  describe "delete_project/1" do
    test "deletes the given project" do
      attrs = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      project = ProjectContext.create_project(attrs)

      ProjectContext.delete_project(project)

      assert ProjectContext.get_project_by_id(project.id) == nil
    end
  end

  describe "get_projects/0" do
    test "returns all projects" do
      attrs1 = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      attrs2 = %{name: "Project 2", description: "Description 2", slug: "project-2", team_id: 2}
      project1 = ProjectContext.create_project(attrs1)
      project2 = ProjectContext.create_project(attrs2)

      result = ProjectContext.get_projects()

      assert result == [project1, project2]
    end
  end

  describe "get_team_projects/3" do
    test "returns the projects for the given team ID with the given offset and limit" do
      attrs1 = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      attrs2 = %{name: "Project 2", description: "Description 2", slug: "project-2", team_id: 1}
      attrs3 = %{name: "Project 3", description: "Description 3", slug: "project-3", team_id: 2}
      project1 = ProjectContext.create_project(attrs1)
      project2 = ProjectContext.create_project(attrs2)
      project3 = ProjectContext.create_project(attrs3)

      result = ProjectContext.get_team_projects(1, 1, 1)

      assert result == [project2]
    end
  end

  describe "count_team_projects/1" do
    test "returns the count of projects for the given team ID" do
      attrs1 = %{name: "Project 1", description: "Description 1", slug: "project-1", team_id: 1}
      attrs2 = %{name: "Project 2", description: "Description 2", slug: "project-2", team_id: 1}
      attrs3 = %{name: "Project 3", description: "Description 3", slug: "project-3", team_id: 2}
      project1 = ProjectContext.create_project(attrs1)
      project2 = ProjectContext.create_project(attrs2)
      project3 = ProjectContext.create_project(attrs3)

      result = ProjectContext.count_team_projects(1)

      assert result == 2
    end
  end

  describe "create_project_meta/1" do
    test "creates a new project meta" do
      attrs = %{key: "foo", value: "bar", project_id: 1}
      project_meta = ProjectContext.create_project_meta(attrs)

      assert project_meta.key == "foo"
      assert project_meta.value == "bar"
      assert project_meta.project_id == 1
    end
  end

  describe "get_project_meta_by_id/1" do
    test "returns the project meta with the given ID" do
      attrs = %{key: "foo", value: "bar", project_id: 1}
      project_meta = ProjectContext.create_project_meta(attrs)

      result = ProjectContext.get_project_meta_by_id(project_meta.id)

      assert result == project_meta
    end
  end
end
