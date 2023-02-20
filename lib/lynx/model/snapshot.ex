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
    field :status, :string
    field :data, :string
    field :team_id, :id

    timestamps()
  end

  @doc false
  def changeset(snapshot, attrs) do
    snapshot
    |> cast(attrs, [
      :uuid,
      :title,
      :description,
      :record_type,
      :record_uuid,
      :status,
      :data,
      :team_id
    ])
    |> validate_required([
      :uuid,
      :title,
      :description,
      :record_type,
      :record_uuid,
      :status,
      :data,
      :team_id
    ])
  end
end
