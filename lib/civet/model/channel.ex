# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Model.Channel do
  @moduledoc """
  Channel Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "channels" do
    field :uuid, Ecto.UUID
    field :first_user_id, :id
    field :second_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [
      :uuid,
      :first_user_id,
      :second_user_id
    ])
    |> validate_required([
      :uuid,
      :first_user_id,
      :second_user_id
    ])
  end
end
