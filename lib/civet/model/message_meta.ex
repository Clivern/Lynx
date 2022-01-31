# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Model.MessageMeta do
  @moduledoc """
  MessageMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "messages_meta" do
    field :key, :string
    field :value, :string
    field :message_id, :id

    timestamps()
  end

  @doc false
  def changeset(message_meta, attrs) do
    message_meta
    |> cast(attrs, [
      :key,
      :value,
      :message_id
    ])
    |> validate_required([
      :key,
      :value,
      :message_id
    ])
  end
end
