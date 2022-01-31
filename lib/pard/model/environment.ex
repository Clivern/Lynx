# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Model.Environment do
  @moduledoc """
  Environment Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "environments" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :slug, :string
    field :username, :string
    field :secret, :string
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [
      :uuid,
      :name,
      :slug,
      :username,
      :secret,
      :project_id
    ])
    |> validate_required([
      :uuid,
      :name,
      :slug,
      :username,
      :secret,
      :project_id
    ])
  end
end
