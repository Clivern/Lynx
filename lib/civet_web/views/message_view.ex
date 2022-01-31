# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.MessageView do
  use CivetWeb, :view

  # Render messages list
  def render("list.json", %{messages: messages, metadata: metadata}) do
    %{
      messages: Enum.map(messages, &render_message/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render message
  def render("index.json", %{message: message}) do
    render_message(message)
  end

  # Render errors
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format message
  defp render_message(message) do
    %{
      id: message.id,
      createdAt: message.inserted_at,
      updatedAt: message.updated_at
    }
  end
end
