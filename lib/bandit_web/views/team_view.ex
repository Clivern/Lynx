# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.TeamView do
  use BanditWeb, :view

  # Render teams list
  def render("list.json", %{teams: teams, metadata: metadata}) do
    %{
      teams: Enum.map(teams, &render_team/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render team
  def render("index.json", %{team: team}) do
    render_team(team)
  end

  # Render errors
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format team
  defp render_team(team) do
    %{
      id: team.uuid,
      name: team.name,
      slug: team.slug,
      description: team.description,
      createdAt: team.inserted_at,
      updatedAt: team.updated_at
    }
  end
end
