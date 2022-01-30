# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Model.User do
  @moduledoc """
  User Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :username, :string
    field :verified, :boolean, default: false
    field :last_seen, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :username,
      :email,
      :password_hash,
      :verified,
      :last_seen
    ])
    |> validate_required([
      :name,
      :username,
      :email,
      :password_hash,
      :verified,
      :last_seen
    ])
    |> validate_length(:username, min: 3, max: 60)
    |> validate_length(:name, min: 3, max: 60)
    |> validate_length(:email, min: 3, max: 60)
  end
end
