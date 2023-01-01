# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Raccoon.Repo.Migrations.CreateEnvironmentsMeta do
  use Ecto.Migration

  def change do
    create table(:environments_meta) do
      add :key, :string
      add :value, :text
      add :environment_id, references(:environments, on_delete: :delete_all)

      timestamps()
    end

    create index(:environments_meta, [:key])
    create index(:environments_meta, [:environment_id])
  end
end
