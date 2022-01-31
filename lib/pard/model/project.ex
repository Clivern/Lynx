# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Model.Project do
  @moduledoc """
  Project Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :description, :string
    field :environment, :string
    field :username, :string
    field :secret, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :uuid,
      :name,
      :description,
      :environment,
      :username,
      :secret
    ])
    |> validate_required([
      :uuid,
      :name,
      :environment,
      :username,
      :secret
    ])
  end
end
