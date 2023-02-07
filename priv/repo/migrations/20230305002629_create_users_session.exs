# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Repo.Migrations.CreateUsersSession do
  use Ecto.Migration

  def change do
    create table(:users_session) do
      add :value, :string
      add :expire_at, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:users_session, [:user_id])
  end
end
