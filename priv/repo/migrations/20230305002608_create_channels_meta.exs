# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateChannelsMeta do
  use Ecto.Migration

  def change do
    create table(:channels_meta) do
      add :key, :string
      add :value, :text
      add :channel_id, references(:channels, on_delete: :delete_all)

      timestamps()
    end

    create index(:channels_meta, [:key])
    create index(:channels_meta, [:channel_id])
  end
end
