# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.ClientView do
  use CivetWeb, :view

  # Render clients list
  def render("list.json", %{clients: clients, metadata: metadata}) do
    %{
      clients: Enum.map(clients, &render_client/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render client
  def render("index.json", %{client: client}) do
    render_client(client)
  end

  # Render errors
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format client
  defp render_client(client) do
    %{
      id: client.id,
      createdAt: client.inserted_at,
      updatedAt: client.updated_at
    }
  end
end
