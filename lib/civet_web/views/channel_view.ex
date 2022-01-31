# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.ChannelView do
  use CivetWeb, :view

  # Render channels list
  def render("list.json", %{channels: channels, metadata: metadata}) do
    %{
      channels: Enum.map(channels, &render_channel/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render channel
  def render("index.json", %{channel: channel}) do
    render_channel(channel)
  end

  # Render errors
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format channel
  defp render_channel(channel) do
    %{
      id: channel.id,
      createdAt: channel.inserted_at,
      updatedAt: channel.updated_at
    }
  end
end
