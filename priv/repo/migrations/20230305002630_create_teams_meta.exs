# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Repo.Migrations.CreateTeamsMeta do
  use Ecto.Migration

  def change do
    create table(:teams_meta) do
      add :key, :string
      add :value, :text
      add :team_id, references(:teams, on_delete: :delete_all)

      timestamps()
    end

    create index(:teams_meta, [:key])
    create index(:teams_meta, [:team_id])
  end
end
