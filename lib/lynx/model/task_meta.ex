# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Model.TaskMeta do
  @moduledoc """
  TaskMeta Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks_meta" do
    field :key, :string
    field :value, :string
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(meta, attrs) do
    meta
    |> cast(attrs, [
      :key,
      :value,
      :task_id
    ])
    |> validate_required([
      :key,
      :value,
      :task_id
    ])
  end
end
