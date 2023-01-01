# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Brangus.Model.EnvironmentMeta do
  @moduledoc """
  EnvironmentMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "environments_meta" do
    field :key, :string
    field :value, :string
    field :environment_id, :id

    timestamps()
  end

  @doc false
  def changeset(lock_meta, attrs) do
    lock_meta
    |> cast(attrs, [
      :key,
      :value,
      :environment_id
    ])
    |> validate_required([
      :key,
      :value,
      :environment_id
    ])
  end
end
