# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateClientsMeta do
  use Ecto.Migration

  def change do
    create table(:clients_meta) do
      add :key, :string
      add :value, :text
      add :client_id, references(:clients, on_delete: :delete_all)

      timestamps()
    end

    create index(:clients_meta, [:key])
    create index(:clients_meta, [:client_id])
  end
end
