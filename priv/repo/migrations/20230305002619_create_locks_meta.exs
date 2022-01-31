# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Repo.Migrations.CreateLocksMeta do
  use Ecto.Migration

  def change do
    create table(:locks_meta) do
      add :key, :string
      add :value, :text
      add :lock_id, references(:locks, on_delete: :delete_all)

      timestamps()
    end

    create index(:locks_meta, [:key])
    create index(:locks_meta, [:lock_id])
  end
end
