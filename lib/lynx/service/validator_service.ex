# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Service.ValidatorService do
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

  @doc """
  Get list value or default
  """
  def get_list(value, default) do
    case is_list(value) do
      true ->
        value

      false ->
        default
    end
  end




  def is_number?(value, err) do
    case Validate.validate(value, type: :number) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_integer?(value, err) do
    case Validate.validate(value, type: :integer) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_float?(value, err) do
    case Validate.validate(value, type: :float) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_string?(value, err) do
    case Validate.validate(value, type: :string) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_list?(value, err) do
    case Validate.validate(value, type: :list) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def not_in?(value, list, err) do
    case Validate.validate(value, type: :string, not_in: list) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def in?(value, list, err) do
    case Validate.validate(value, type: :string, in: list) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_not_empty?(value, err) do
    case Validate.validate(value, required: true) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_uuid?(value, err) do
    case Validate.validate(value, type: :string, uuid: true) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_url?(value, err) do
    case Validate.validate(value, type: :string, url: true) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end

  def is_email?(value, err) do
    case Validate.validate(value, type: :string, regex: ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/) do
      {:ok, value} ->
        {:ok, value}
      {:error, _} ->
        {:error, err}
    end
  end
end
