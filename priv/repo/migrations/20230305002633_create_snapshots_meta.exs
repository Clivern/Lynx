# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Repo.Migrations.CreateSnapshotsMeta do
  use Ecto.Migration

  def change do
    create table(:snapshots_meta) do
      add :key, :string
      add :value, :text
      add :snapshot_id, references(:snapshots, on_delete: :delete_all)

      timestamps()
    end

    create index(:snapshots_meta, [:key])
    create index(:snapshots_meta, [:snapshot_id])
  end
end
