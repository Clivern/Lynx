# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Repo do
  use Ecto.Repo,
    otp_app: :bandit,
    adapter: Ecto.Adapters.Postgres
end
