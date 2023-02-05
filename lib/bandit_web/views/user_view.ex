# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.UserView do
  use BanditWeb, :view

  # Render users list
  def render("list.json", %{users: users, metadata: metadata}) do
    %{
      users: Enum.map(users, &render_user/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render user
  def render("index.json", %{user: user}) do
    render_user(user)
  end

  # Render errors
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format user
  defp render_user(user) do
    %{
      id: user.uuid,
      email: user.email,
      name: user.name,
      role: user.role,
      createdAt: user.inserted_at,
      updatedAt: user.updated_at
    }
  end
end
