# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Module.StateModule do
  @moduledoc """
  State Module
  """
  alias Civet.Context.StateContext
  alias Civet.Context.ProjectContext

  @doc """
  Get latest state
  """
  def get_latest_state(params \\ %{}) do
    project =
      ProjectContext.get_project_by_name_environment(
        params[:project],
        params[:environment]
      )

    case project do
      nil ->
        {:not_found, "Project not found"}

      _ ->
        result = StateContext.get_latest_state_by_project_id(project.id)

        case result do
          nil ->
            {:no_state, ""}

          _ ->
            {:state_found, result}
        end
    end
  end

  @doc """
  Add a new state
  """
  def add_state(params \\ %{}) do
    project =
      ProjectContext.get_project_by_name_environment(
        params[:project],
        params[:environment]
      )

    case project do
      nil ->
        {:not_found, "Project not found"}

      _ ->
        state =
          StateContext.new_state(%{
            project_id: project.id,
            name: params[:state_name],
            value: params[:state_value]
          })

        case StateContext.create_state(state) do
          {:ok, _} ->
            {:ok, ""}

          {:error, changeset} ->
            messages =
              changeset.errors()
              |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

            {:error, Enum.at(messages, 0)}
        end
    end
  end
end
