# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :uuid, :uuid
      add :slug, :string
      add :icon, :string
      add :is_private, :boolean, default: false
      add :country, :string, null: true
      add :state, :string, null: true
      add :user_id, references(:users, on_delete: :delete_all), null: true
      add :client_id, references(:clients, on_delete: :delete_all), null: true

      timestamps()
    end

    create index(:rooms, [:uuid])
    create index(:rooms, [:slug])
    create index(:rooms, [:user_id])
    create index(:rooms, [:client_id])
  end
end

