# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.EnvironmentView do
  use BanditWeb, :view

  # Render environments list
  def render("list.json", %{environments: environments, metadata: metadata}) do
    %{
      environments: Enum.map(environments, &render_environment/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render environment
  def render("index.json", %{environment: environment}) do
    render_environment(environment)
  end

  # Render errors
  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  # Format environment
  defp render_environment(environment) do
    %{
      id: environment.uuid,
      name: environment.name,
      slug: environment.slug,
      username: environment.username,
      secret: environment.secret,
      createdAt: environment.inserted_at,
      updatedAt: environment.updated_at
    }
  end
end
