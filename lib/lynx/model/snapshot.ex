# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Model.Snapshot do
  @moduledoc """
  Snapshot Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "snapshots" do
    field :uuid, Ecto.UUID
    field :title, :string
    field :description, :string
    field :record_type, :string
    field :record_uuid, :string
    field :data, :string

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [
      :uuid,
      :title,
      :description,
      :record_type,
      :record_uuid,
      :data
    ])
    |> validate_required([
      :uuid,
      :title,
      :description,
      :record_type,
      :record_uuid,
      :data
    ])
  end
end
