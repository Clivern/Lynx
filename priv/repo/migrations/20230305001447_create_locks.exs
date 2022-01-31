# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateLocks do
  use Ecto.Migration

  def change do
    create table(:locks) do
      add :uuid, :uuid
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:locks, [:project_id])
  end
end
