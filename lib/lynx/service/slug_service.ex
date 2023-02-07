# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Service.SlugService do
  @moduledoc """
  Slug Service
  """

  @doc """
  Create a new slug
  """
  def create(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "-")
    |> String.replace(~r/-+/, "-")
    |> String.trim("-")
  end
end
