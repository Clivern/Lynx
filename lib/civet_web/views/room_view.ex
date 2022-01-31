# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.RoomView do
  use CivetWeb, :view

  # Render rooms list
  def render("list.json", %{rooms: rooms, metadata: metadata}) do
    %{
      rooms: Enum.map(rooms, &render_room/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render room
  def render("index.json", %{room: room}) do
    render_room(room)
  end

  # Render errors
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format room
  defp render_room(room) do
    %{
      id: room.id,
      createdAt: room.inserted_at,
      updatedAt: room.updated_at
    }
  end
end
