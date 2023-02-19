# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Worker.SnapshotWorker do
  use GenServer

  require Logger

  alias Lynx.Context.SnapshotContext
  alias Lynx.Module.SnapshotModule

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  ## Callbacks
  @impl true
  def init(state) do
    Logger.info("Snapshot Worker Started")

    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_info(:fire, state) do
    # Process any create snapshot request
    create_snapshots()

    # Process any restore request
    restore_snapshots()

    # Reschedule once more
    schedule_work()

    {:noreply, state}
  end

  defp create_snapshots do
    Logger.info("Create any Outstanding Snapshot")

    snapshots = SnapshotContext.get_snapshots_by_status("pending")

    for snapshot <- snapshots do
      Logger.info("Snapshot with ID #{snapshot.uuid} will start")

      SnapshotContext.update_snapshot(snapshot, %{status: "running"})

      case SnapshotModule.take_snapshot(snapshot.uuid) do
        {:ok, data} ->
          Logger.info("Snapshot with ID #{snapshot.uuid} succeeded")

          SnapshotContext.update_snapshot(snapshot, %{
            status: "success",
            data: Jason.encode!(data)
          })

        {:error, msg} ->
          Logger.error("Snapshot with ID #{snapshot.uuid} failed: #{msg}")

          SnapshotContext.update_snapshot(snapshot, %{
            status: "failure",
            data: Jason.encode!(%{reason: msg})
          })
      end
    end
  end

  defp restore_snapshots do
    Logger.info("Restore any Outstanding Snapshot")
  end

  defp schedule_work do
    # We schedule the work to happen in 30 seconds
    Process.send_after(self(), :fire, 30 * 1000)
  end
end
