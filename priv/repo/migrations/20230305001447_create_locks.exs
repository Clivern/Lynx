# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Leopard.Repo.Migrations.CreateLocks do
  use Ecto.Migration

  def change do
    create table(:locks) do
      add :uuid, :uuid
      add :project_id, references(:projects, on_delete: :delete_all)
      add :tf_uuid, :string
      add :tf_operation, :string
      add :tf_info, :string
      add :tf_who, :string
      add :tf_version, :string
      add :tf_path, :string
      add :is_active, :boolean, default: true

      timestamps()
    end

    create index(:locks, [:project_id])
    create index(:locks, [:tf_uuid])
  end
end
