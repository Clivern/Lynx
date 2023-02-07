# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Repo.Migrations.CreateProjectsMeta do
  use Ecto.Migration

  def change do
    create table(:projects_meta) do
      add :key, :string
      add :value, :text
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:projects_meta, [:key])
    create index(:projects_meta, [:project_id])
  end
end
