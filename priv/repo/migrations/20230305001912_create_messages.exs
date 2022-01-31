# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text
      add :uuid, :uuid
      add :type, :string
      add :client_id, references(:clients, on_delete: :delete_all)
      add :room_id, references(:rooms, on_delete: :delete_all), null: true
      add :channel_id, references(:channels, on_delete: :delete_all), null: true

      timestamps()
    end

    create index(:messages, [:client_id])
    create index(:messages, [:room_id])
    create index(:messages, [:channel_id])
  end
end
