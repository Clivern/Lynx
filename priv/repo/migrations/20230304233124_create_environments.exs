# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Repo.Migrations.CreateEnvironments do
  use Ecto.Migration

  def change do
    create table(:environments) do
      add :uuid, :uuid
      add :name, :string
      add :slug, :string
      add :username, :string
      add :secret, :string
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:environments, [:slug])
  end
end