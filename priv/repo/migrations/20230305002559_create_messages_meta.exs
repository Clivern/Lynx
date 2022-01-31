# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateMessagesMeta do
  use Ecto.Migration

  def change do
    create table(:messages_meta) do
      add :key, :string
      add :value, :text
      add :message_id, references(:messages, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages_meta, [:key])
    create index(:messages_meta, [:message_id])
  end
end
