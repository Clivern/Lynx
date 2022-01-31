# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateStatesMeta do
  use Ecto.Migration

  def change do
    create table(:states_meta) do
      add :key, :string
      add :value, :text
      add :state_id, references(:states, on_delete: :delete_all)

      timestamps()
    end

    create index(:states_meta, [:key])
    create index(:states_meta, [:state_id])
  end
end
