# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Model.Task do
  @moduledoc """
  Task Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :uuid, Ecto.UUID
    field :payload, :string
    field :result, :string
    # :pending, running, success, failure, skipped
    field :status, :string
    field :run_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [
      :uuid,
      :payload,
      :result,
      :status,
      :run_at
    ])
    |> validate_required([
      :uuid,
      :payload,
      :result,
      :status,
      :run_at
    ])
  end
end
