# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Repo do
  use Ecto.Repo,
    otp_app: :civet,
    adapter: Ecto.Adapters.Postgres

  # adapter: Ecto.Adapters.SQLite3
end
