# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Octopus.Model.UserMeta do
  @moduledoc """
  UserMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users_meta" do
    field :key, :string
    field :value, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_meta, attrs) do
    user_meta
    |> cast(attrs, [
      :key,
      :value,
      :user_id
    ])
    |> validate_required([
      :key,
      :value,
      :user_id
    ])
  end
end
