# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Model.ChannelMeta do
  @moduledoc """
  ChannelMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "channels_meta" do
    field :key, :string
    field :value, :string
    field :channel_id, :id

    timestamps()
  end

  @doc false
  def changeset(channel_meta, attrs) do
    channel_meta
    |> cast(attrs, [
      :key,
      :value,
      :channel_id
    ])
    |> validate_required([
      :key,
      :value,
      :channel_id
    ])
  end
end
