# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Model.Team do
  @moduledoc """
  Team Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :slug, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [
      :uuid,
      :name,
      :slug,
      :description
    ])
    |> validate_required([
      :uuid,
      :name,
      :slug,
      :description
    ])
  end
end
