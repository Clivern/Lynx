# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateRoomsMeta do
  use Ecto.Migration

  def change do
    create table(:rooms_meta) do
      add :key, :string
      add :value, :text
      add :room_id, references(:rooms, on_delete: :delete_all)

      timestamps()
    end

    create index(:rooms_meta, [:key])
    create index(:rooms_meta, [:room_id])
  end
end
