# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.UserView do
  use CivetWeb, :view

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
      id: user.id,
      name: user.name,
      email: user.email,
      username: user.username,
      age: user.age,
      country: user.country,
      state: user.state,
      gender: user.gender,
      verified: user.verified,
      last_seen: user.last_seen,
      createdAt: user.inserted_at,
      updatedAt: user.updated_at
    }
  end
end
