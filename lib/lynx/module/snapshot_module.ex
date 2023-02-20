# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.SnapshotModule do
  @moduledoc """
  Snapshot Module
  """

  alias Lynx.Context.SnapshotContext
  alias Lynx.Module.TeamModule
  alias Lynx.Context.ProjectContext
  alias Lynx.Context.EnvironmentContext
  alias Lynx.Context.StateContext
  alias Lynx.Module.TaskModule

  @doc """
  Get Snapshot by UUID
  """
  def get_snapshot_by_uuid(uuid) do
    case SnapshotContext.get_snapshot_by_uuid(uuid) do
      nil ->
        {:not_found, "Snapshot with UUID #{uuid} not found"}

      snapshot ->
        {:ok, snapshot}
    end
  end

  @doc """
  Create A Snapshot
  """
  def create_snapshot(data \\ %{}) do
    snapshot =
      SnapshotContext.new_snapshot(%{
        title: data[:title],
        description: data[:description],
        record_type: data[:record_type],
        record_uuid: data[:record_uuid],
        status: data[:status],
        data: data[:data],
        team_id: data[:team_id]
      })

    case SnapshotContext.create_snapshot(snapshot) do
      {:ok, snapshot} ->
        {:ok, snapshot}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

  @doc """
  Get User Snapshots
  """
  def get_snapshots(user_id, offset, limit) do
    user_teams = TeamModule.get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    SnapshotContext.get_snapshots_by_teams(teams_ids, offset, limit)
  end

  @doc """
  Get Snapshots
  """
  def get_snapshots(offset, limit) do
    SnapshotContext.get_snapshots(offset, limit)
  end

  @doc """
  Count Snapshots
  """
  def count_snapshots() do
    SnapshotContext.count_snapshots()
  end

  @doc """
  Count User Snapshots
  """
  def count_snapshots(user_id) do
    user_teams = TeamModule.get_user_teams(user_id)

    teams_ids = []

    teams_ids =
      for user_team <- user_teams do
        teams_ids ++ user_team.id
      end

    SnapshotContext.count_snapshots_by_teams(teams_ids)
  end

  @doc """
  Restore Snapshots By UUID
  """
  def restore_snapshot_by_uuid(uuid) do
    case get_snapshot_by_uuid(uuid) do
      {:ok, snapshot} ->
        result =
          TaskModule.create_task(%{
            payload:
              Jason.encode!(%{
                action: "restore_snapshot",
                snapshot_uuid: snapshot.uuid,
                snapshot_id: snapshot.id
              }),
            result: "{}",
            status: "pending",
            run_at: DateTime.utc_now()
          })

        case result do
          {:error, msg} ->
            {:error, msg}

          {:ok, task} ->
            {:ok, task}
        end

      {:not_found, msg} ->
        {:not_found, msg}
    end
  end

  @doc """
  Take Snapshot
  """
  def take_snapshot(uuid) do
    case get_snapshot_by_uuid(uuid) do
      {:ok, snapshot} ->
        case {String.to_atom(snapshot.record_type), snapshot.record_uuid} do
          {:project, p_uuid} ->
            project_snapshot_data(p_uuid)

          {:environment, e_uuid} ->
            environment_snapshot_data(e_uuid)
        end

      {:not_found, msg} ->
        {:error, msg}
    end
  end

  @doc """
  Restore Snapshot
  """
  def restore_snapshot(uuid) do
    case get_snapshot_by_uuid(uuid) do
      {:ok, snapshot} ->
        data = Jason.decode!(snapshot.data)

        for environment <- data["environments"] do
          case EnvironmentContext.get_env_by_uuid(environment["uuid"]) do
            nil ->
              recreate_environment(environment)
              {:ok, ""}

            env ->
              EnvironmentContext.delete_env(env)
              recreate_environment(environment)
              {:ok, ""}
          end
        end

      {:not_found, msg} ->
        {:error, msg}
    end

    {:ok, ""}
  end

  defp recreate_environment(new_environment) do
    # @TODO: Raise error on failure
    data =
      EnvironmentContext.new_env(%{
        slug: new_environment["slug"],
        name: new_environment["name"],
        username: new_environment["username"],
        secret: new_environment["secret"],
        project_id: new_environment["project_id"],
        uuid: new_environment["uuid"]
      })

    case EnvironmentContext.create_env(data) do
      {:ok, environment} ->
        for state <- new_environment["states"] do
          data =
            StateContext.new_state(%{
              name: state["name"],
              value: state["value"],
              environment_id: environment.id,
              uuid: state["uuid"]
            })

          case StateContext.create_state(data) do
            {:ok, _} ->
              {:ok, ""}

            {:error, changeset} ->
              messages =
                changeset.errors()
                |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

              {:error, Enum.at(messages, 0)}
          end
        end

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

  defp project_snapshot_data(uuid) do
    case ProjectContext.get_project_by_uuid(uuid) do
      nil ->
        {:error, "Project with ID #{uuid} not found"}

      project ->
        data = %{
          id: project.id,
          uuid: project.uuid,
          name: project.name,
          slug: project.slug,
          description: project.description,
          team_id: project.team_id,
          inserted_at: project.inserted_at,
          updated_at: project.updated_at,
          environments: []
        }

        environments =
          for environment <- EnvironmentContext.get_project_envs(project.id, 0, 10000) do
            states =
              for state <- StateContext.get_states_by_environment_id(environment.id) do
                %{
                  id: state.id,
                  uuid: state.uuid,
                  name: state.name,
                  value: state.value,
                  environment_id: state.environment_id,
                  inserted_at: state.inserted_at,
                  updated_at: state.updated_at
                }
              end

            %{
              id: environment.id,
              uuid: environment.uuid,
              name: environment.name,
              slug: environment.slug,
              username: environment.username,
              secret: environment.secret,
              project_id: environment.project_id,
              inserted_at: environment.inserted_at,
              updated_at: environment.updated_at,
              states: states
            }
          end

        {:ok, %{data | environments: environments}}
    end
  end

  defp environment_snapshot_data(uuid) do
    case EnvironmentContext.get_env_by_uuid(uuid) do
      nil ->
        {:error, "Environment with ID #{uuid} not found"}

      environment ->
        case ProjectContext.get_project_by_id(environment.project_id) do
          nil ->
            {:error, "Project with ID #{environment.project_id} not found"}

          project ->
            data = %{
              id: project.id,
              uuid: project.uuid,
              name: project.name,
              slug: project.slug,
              description: project.description,
              team_id: project.team_id,
              inserted_at: project.inserted_at,
              updated_at: project.updated_at,
              environments: []
            }

            states =
              for state <- StateContext.get_states_by_environment_id(environment.id) do
                %{
                  id: state.id,
                  uuid: state.uuid,
                  name: state.name,
                  value: state.value,
                  environment_id: state.environment_id,
                  inserted_at: state.inserted_at,
                  updated_at: state.updated_at
                }
              end

            environments = [
              %{
                id: environment.id,
                uuid: environment.uuid,
                name: environment.name,
                slug: environment.slug,
                username: environment.username,
                secret: environment.secret,
                project_id: environment.project_id,
                inserted_at: environment.inserted_at,
                updated_at: environment.updated_at,
                states: states
              }
            ]

            {:ok, %{data | environments: environments}}
        end
    end
  end

  @doc """
  Delete Snapshot by UUID
  """
  def delete_snapshot_by_uuid(uuid) do
    case get_snapshot_by_uuid(uuid) do
      {:not_found, msg} ->
        {:not_found, msg}

      {:ok, snapshot} ->
        SnapshotContext.delete_snapshot(snapshot)
        {:ok, "Snapshot with ID #{uuid} deleted successfully"}
    end
  end
end
