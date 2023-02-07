# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Repo.Migrations.CreateLocks do
  use Ecto.Migration

  def change do
    create table(:locks) do
      add :uuid, :uuid
      add :operation, :string
      add :info, :string
      add :who, :string
      add :version, :string
      add :path, :string
      add :is_active, :boolean, default: true
      add :environment_id, references(:environments, on_delete: :delete_all)

      timestamps()
    end

    create index(:locks, [:environment_id])
  end
end
