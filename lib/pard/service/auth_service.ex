# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Service.AuthService do
  @moduledoc """
  Auth Service Module
  """

  @doc """
  Hash password
  """
  def hash_password(password, salt) do
    Bcrypt.Base.hash_password(password, salt)
  end

  @doc """
  Get random salt
  """
  def get_random_salt(rounds \\ 12, legacy \\ false) do
    Bcrypt.Base.gen_salt(rounds, legacy)
  end

  @doc """
  Get random UUID
  """
  def get_uuid() do
    Ecto.UUID.generate()
  end
end
