# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Model.ProjectMeta do
  @moduledoc """
  ProjectMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "projects_meta" do
    field :key, :string
    field :value, :string
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(project_meta, attrs) do
    project_meta
    |> cast(attrs, [
      :key,
      :value,
      :project_id
    ])
    |> validate_required([
      :key,
      :value,
      :project_id
    ])
  end
end
