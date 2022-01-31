# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Model.Lock do
  @moduledoc """
  Lock Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "locks" do
    field :uuid, Ecto.UUID
    field :environment_id, :id
    field :tf_uuid, :string
    field :tf_operation, :string
    field :tf_info, :string
    field :tf_who, :string
    field :tf_version, :string
    field :tf_path, :string
    field :is_active, :boolean

    timestamps()
  end

  @doc false
  def changeset(lock, attrs) do
    lock
    |> cast(attrs, [
      :uuid,
      :environment_id,
      :tf_uuid,
      :tf_operation,
      :tf_info,
      :tf_who,
      :tf_version,
      :tf_path,
      :is_active
    ])
    |> validate_required([
      :uuid,
      :environment_id
    ])
  end
end
