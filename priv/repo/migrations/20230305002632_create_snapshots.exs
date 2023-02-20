# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Repo.Migrations.CreateSnapshots do
  use Ecto.Migration

  def change do
    create table(:snapshots) do
      add :uuid, :uuid
      add :title, :string
      add :description, :string
      add :status, :string
      add :record_type, :string
      add :record_uuid, :string
      add :data, :text
      add :team_id, references(:teams, on_delete: :delete_all)

      timestamps()
    end

    create index(:snapshots, [:uuid])
  end
end
