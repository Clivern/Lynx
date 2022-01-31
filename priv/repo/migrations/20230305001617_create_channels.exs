# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :uuid, :uuid
      add :first_user_id, references(:users, on_delete: :delete_all)
      add :second_user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:channels, [:first_user_id])
    create index(:channels, [:second_user_id])
  end
end
