# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string, unique: true
      add :email, :string, unique: true
      add :password_hash, :string
      add :verified, :boolean, default: false
      add :gender, :string, default: "male"
      add :country, :string, default: "united_states"
      add :state, :string, default: "alabama"
      add :age, :integer
      add :last_seen, :utc_datetime

      timestamps()
    end

    create index(:users, [:username])
    create index(:users, [:email])
  end
end
