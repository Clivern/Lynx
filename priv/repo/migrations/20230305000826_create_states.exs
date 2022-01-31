# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Campfire.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :uuid, :uuid
      add :name, :string
      add :value, :text
      add :environment_id, references(:environments, on_delete: :delete_all)

      timestamps()
    end

    create index(:states, [:name])
  end
end
