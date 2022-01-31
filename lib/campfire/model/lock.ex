# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Campfire.Model.Lock do
  @moduledoc """
  Lock Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "locks" do
    field :uuid, Ecto.UUID
    field :environment_id, :id
    field :operation, :string
    field :info, :string
    field :who, :string
    field :version, :string
    field :path, :string
    field :is_active, :boolean

    timestamps()
  end

  @doc false
  def changeset(lock, attrs) do
    lock
    |> cast(attrs, [
      :uuid,
      :environment_id,
      :operation,
      :info,
      :who,
      :version,
      :path,
      :is_active
    ])
    |> validate_required([
      :uuid,
      :environment_id
    ])
  end
end
