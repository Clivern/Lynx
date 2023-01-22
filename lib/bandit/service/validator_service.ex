# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Service.ValidatorService do
  @moduledoc """
  Validator Service
  """

  @doc """
  Check if a value is an integer
  """
  def validate_int(value) do
    case is_integer(value) do
      true ->
        true

      false ->
        try do
          _ = String.to_integer(value)
          true
        rescue
          _ -> false
        end
    end
  end

  @doc """
  Convert a value into an integer
  """
  def parse_int(value) do
    case is_integer(value) do
      true ->
        value

      false ->
        String.to_integer(value)
    end
  end

  @doc """
  Check if value is empty or not
  """
  def is_empty(value) do
    case {is_integer(value), String.valid?(value), value == nil} do
      {_, _, true} ->
        true

      {true, _, _} ->
        String.trim(to_string(value)) == ""

      {false, true, _} ->
        String.trim(value) == ""

      {_, _, _} ->
        true
    end
  end

  @doc """
  Get int value or default
  """
  def get_int(value, default) do
    case validate_int(value) do
      true -> parse_int(value)
      false -> default
    end
  end

  @doc """
  Get string value or default
  """
  def get_str(value, default) do
    case is_empty(value) do
      true -> default
      false -> value
    end
  end
end
