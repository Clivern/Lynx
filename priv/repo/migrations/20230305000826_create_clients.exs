# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :uuid, :uuid
      add :secret, :string
      add :username, :string, unique: true
      add :gender, :string, default: "male"
      add :country, :string, default: "united_states"
      add :state, :string, default: "alabama"
      add :age, :integer
      add :last_seen, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all), null: true

      timestamps()
    end

    create index(:clients, [:uuid])
    create index(:clients, [:secret])
    create index(:clients, [:username])
    create index(:clients, [:user_id])
  end
end
