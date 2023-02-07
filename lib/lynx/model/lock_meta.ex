# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Model.LockMeta do
  @moduledoc """
  LockMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "locks_meta" do
    field :key, :string
    field :value, :string
    field :lock_id, :id

    timestamps()
  end

  @doc false
  def changeset(lock_meta, attrs) do
    lock_meta
    |> cast(attrs, [
      :key,
      :value,
      :lock_id
    ])
    |> validate_required([
      :key,
      :value,
      :lock_id
    ])
  end
end
