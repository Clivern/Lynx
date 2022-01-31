# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Octopus.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uuid, :uuid
      add :name, :string
      add :email, :string, unique: true
      add :password_hash, :string
      add :verified, :boolean, default: false
      add :last_seen, :utc_datetime
      add :role, :string
      add :api_key, :string

      timestamps()
    end

    create index(:users, [:email])
  end
end
