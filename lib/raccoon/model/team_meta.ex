# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Raccoon.Model.TeamMeta do
  @moduledoc """
  TeamMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "teams_meta" do
    field :key, :string
    field :value, :string
    field :team_id, :id

    timestamps()
  end

  @doc false
  def changeset(lock_meta, attrs) do
    lock_meta
    |> cast(attrs, [
      :key,
      :value,
      :team_id
    ])
    |> validate_required([
      :key,
      :value,
      :team_id
    ])
  end
end
