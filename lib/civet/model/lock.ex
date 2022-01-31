# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Model.Lock do
  @moduledoc """
  Lock Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "locks" do
    field :uuid, Ecto.UUID
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(lock, attrs) do
    lock
    |> cast(attrs, [
      :uuid,
      :project_id
    ])
    |> validate_required([
      :uuid,
      :project_id
    ])
  end
end
