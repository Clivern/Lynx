# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Model.Config do
  @moduledoc """
  Config Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "configs" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [
      :uuid,
      :name,
      :value
    ])
    |> validate_required([
      :uuid,
      :name,
      :value
    ])
    |> validate_length(:name, min: 3, max: 200)
    |> validate_length(:value, min: 3, max: 2000)
  end
end
