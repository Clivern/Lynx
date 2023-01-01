# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Raccoon.Repo do
  use Ecto.Repo,
    otp_app: :raccoon,
    adapter: Ecto.Adapters.Postgres
end
