# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Module.ProjectModule do
  @moduledoc """
  Project Module
  """
  alias Pard.Context.ProjectContext

  @doc """
  Validate Auth Data
  """
  def is_allowed(params \\ %{}) do
    project =
      ProjectContext.get_project_by_name_environment(
        params[:project],
        params[:environment]
      )

    case project do
      nil ->
        {:not_found, "Project not found"}

      _ ->
        case {project.username == params[:username], project.secret == params[:secret]} do
          {true, true} ->
            {:success, "A valid username and secret"}

          _ ->
            {:failed, "Invalid username or secret"}
        end
    end
  end
end
