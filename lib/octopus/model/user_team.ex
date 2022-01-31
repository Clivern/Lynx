# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Octopus.Model.UserTeam do
  @moduledoc """
  UserTeam Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "user_teams" do
    field :uuid, Ecto.UUID
    field :user_id, :id
    field :team_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_meta, attrs) do
    user_meta
    |> cast(attrs, [
      :uuid,
      :team_id,
      :user_id
    ])
    |> validate_required([
      :uuid,
      :team_id,
      :user_id
    ])
  end
end
