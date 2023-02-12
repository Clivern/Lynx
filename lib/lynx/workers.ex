# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Workers do
  use Supervisor

  def start_link(init_state) do
    Supervisor.start_link(__MODULE__, init_state, name: __MODULE__)
  end

  @impl true
  def init(_init_state) do
    children = [
      {Lynx.Worker.SnapshotWorker, %{}}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
