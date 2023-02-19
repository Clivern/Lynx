# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Module.TaskModule do
  @moduledoc """
  User Module
  """

  alias Lynx.Context.TaskContext

  @doc """
  Create Task
  """
  def create_task(data \\ %{}) do
    task =
      TaskContext.new_task(%{
        payload: data[:payload],
        result: data[:result],
        status: data[:status],
        run_at: data[:run_at]
      })

    case TaskContext.create_task(task) do
      {:ok, task} ->
        {:ok, task}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

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
