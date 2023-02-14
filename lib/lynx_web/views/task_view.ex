# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.TaskView do
  use LynxWeb, :view

  # Render task
  def render("index.json", %{task: task}) do
    render_task(task)
  end

  # Render errors
  def render("error.json", %{message: message}) do
    %{errorMessage: message}
  end

  # Format task
  defp render_task(task) do
    %{
      id: task.uuid,
      status: task.status,
      runAt: task.run_at,
      createdAt: task.inserted_at,
      updatedAt: task.updated_at
    }
  end
end
