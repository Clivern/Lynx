# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :uuid, :uuid
      add :name, :string
      add :value, :text

      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:states, [:name])
    create index(:states, [:project_id])
  end
end
