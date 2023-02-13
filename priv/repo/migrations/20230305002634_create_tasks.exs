# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :uuid, :uuid
      add :payload, :string
      add :result, :string
      add :status, :string
      add :run_at, :utc_datetime

      timestamps()
    end

    create index(:tasks, [:uuid])
  end
end
