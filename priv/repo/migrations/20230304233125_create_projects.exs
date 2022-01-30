# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :uuid, :uuid
      add :name, :string
      add :description, :string
      add :environment, :string
      add :username, :string
      add :secret, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:projects, [:name])
    create index(:projects, [:environment])
  end
end
