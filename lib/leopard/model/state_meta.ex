# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Leopard.Model.StateMeta do
  @moduledoc """
  StateMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "states_meta" do
    field :key, :string
    field :value, :string
    field :state_id, :id

    timestamps()
  end

  @doc false
  def changeset(state_meta, attrs) do
    state_meta
    |> cast(attrs, [
      :key,
      :value,
      :state_id
    ])
    |> validate_required([
      :key,
      :value,
      :state_id
    ])
  end
end
