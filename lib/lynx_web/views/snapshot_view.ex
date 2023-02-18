# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.SnapshotView do
  use LynxWeb, :view

  alias Lynx.Module.TeamModule

  # Render snapshots list
  def render("list.json", %{snapshots: snapshots, metadata: metadata}) do
    %{
      snapshots: Enum.map(snapshots, &render_snapshot/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render snapshot
  def render("index.json", %{snapshot: snapshot}) do
    render_snapshot(snapshot)
  end

  # Render errors
  def render("error.json", %{message: message}) do
    %{errorMessage: message}
  end

  # Format snapshot
  defp render_snapshot(snapshot) do
    {_, team} = TeamModule.get_team_by_id(snapshot.team_id)

    %{
      id: snapshot.uuid,
      title: snapshot.title,
      description: snapshot.description,
      record_type: snapshot.record_type,
      record_uuid: snapshot.record_uuid,
      status: snapshot.status,
      team: %{
        id: team.uuid,
        name: team.name,
        slug: team.slug
      },
      createdAt: snapshot.inserted_at,
      updatedAt: snapshot.updated_at
    }
  end
end
