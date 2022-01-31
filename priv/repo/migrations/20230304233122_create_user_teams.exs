# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Campfire.Repo.Migrations.CreateUserTeams do
  use Ecto.Migration

  def change do
    create table(:user_teams) do
      add :uuid, :uuid
      add :user_id, references(:users, on_delete: :delete_all)
      add :team_id, references(:teams, on_delete: :delete_all)

      timestamps()
    end

    create index(:user_teams, [:user_id])
    create index(:user_teams, [:team_id])
  end
end
