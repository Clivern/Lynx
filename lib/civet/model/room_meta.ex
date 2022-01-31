# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Model.RoomMeta do
  @moduledoc """
  RoomMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms_meta" do
    field :key, :string
    field :value, :string
    field :room_id, :id

    timestamps()
  end

  @doc false
  def changeset(room_meta, attrs) do
    room_meta
    |> cast(attrs, [
      :key,
      :value,
      :room_id
    ])
    |> validate_required([
      :key,
      :value,
      :room_id
    ])
  end
end
