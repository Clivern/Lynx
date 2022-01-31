# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Campfire.Repo.Migrations.CreateConfigs do
  use Ecto.Migration

  def change do
    create table(:configs) do
      add :uuid, :uuid
      add :name, :string, unique: true
      add :value, :text

      timestamps()
    end

    create index(:configs, [:name])
  end
end
