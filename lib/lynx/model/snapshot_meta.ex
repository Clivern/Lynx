# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Model.SnapshotMeta do
  @moduledoc """
  SnapshotMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "snapshots_meta" do
    field :key, :string
    field :value, :string
    field :snapshot_id, :id

    timestamps()
  end

  @doc false
  def changeset(meta, attrs) do
    meta
    |> cast(attrs, [
      :key,
      :value,
      :snapshot_id
    ])
    |> validate_required([
      :key,
      :value,
      :snapshot_id
    ])
  end
end
