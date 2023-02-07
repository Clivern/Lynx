# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Repo.Migrations.CreateUsersMeta do
  use Ecto.Migration

  def change do
    create table(:users_meta) do
      add :key, :string
      add :value, :text
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:users_meta, [:key])
    create index(:users_meta, [:user_id])
  end
end
