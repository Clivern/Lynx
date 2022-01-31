# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Model.Room do
  @moduledoc """
  Room Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :country, :string
    field :icon, :string
    field :is_private, :boolean, default: false
    field :name, :string
    field :slug, :string
    field :state, :string
    field :uuid, Ecto.UUID
    field :user_id, :id
    field :client_id, :id

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [
      :name,
      :uuid,
      :slug,
      :icon,
      :is_private,
      :country,
      :state,
      :user_id,
      :client_id
    ])
    |> validate_required([
      :name,
      :uuid,
      :slug,
      :icon,
      :is_private,
      :country,
      :state
    ])
    |> validate_length(:name, min: 3, max: 60)
  end
end
