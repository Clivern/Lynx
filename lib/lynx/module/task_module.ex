# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.TaskModule do
  @moduledoc """
  User Module
  """

  alias Lynx.Context.TaskContext

  @doc """
  Get task by UUID
  """
  def get_task_by_uuid(uuid) do
    case TaskContext.get_task_by_uuid(uuid) do
      nil ->
        {:not_found, "Task with UUID #{uuid} not found"}

      task ->
        {:ok, task}
    end
  end
end
