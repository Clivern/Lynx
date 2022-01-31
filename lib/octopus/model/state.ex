# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Octopus.Model.State do
  @moduledoc """
  State Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :value, :string
    field :environment_id, :id

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [
      :uuid,
      :name,
      :value,
      :environment_id
    ])
    |> validate_required([
      :uuid,
      :name,
      :value,
      :environment_id
    ])
  end
end
