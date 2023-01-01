# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Brangus.Service.AuthService do
  @moduledoc """
  Auth Service
  """

  alias Brangus.Context.UserContext

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

  @doc """
  Verify password
  """
  def verify_password(password, hash) do
    Bcrypt.verify_pass(password, hash)
  end

  @doc """
  Login
  """
  def login(email, password) when not is_nil(email) and not is_nil(password) do
    user = UserContext.get_user_by_email(email)

    case user do
      nil ->
        {:error, "Invalid email or password"}

      user ->
        case verify_password(password, user.password_hash) do
          true ->
            authenticate(user.id)

          false ->
            {:error, "Invalid email or password"}
        end
    end
  end

  def login(email, password) when is_nil(email) or is_nil(password) do
    {:error, "Invalid email or password"}
  end

  @doc """
  Refresh Session
  """
  def refresh_session(session) do
    diff = DateTime.diff(session.expire_at, DateTime.utc_now(), :second)

    # If expired
    if diff < 1 do
      result =
        UserContext.update_user_session(session, %{
          expire_at: DateTime.utc_now() |> DateTime.add(600, :second),
          value: get_random_salt(30)
        })

      case result do
        {:ok, session} ->
          {true, session}

        {:error, changeset} ->
          messages =
            changeset.errors()
            |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

          {:error, Enum.at(messages, 0)}
      end
    else
      {false, session}
    end
  end

  @doc """
  Is Authenticated
  """
  def is_authenticated(user_id, session_value)
      when not is_nil(user_id) and not is_nil(session_value) do
    result = UserContext.get_user_session_by_id_key(user_id, session_value)

    case result do
      nil ->
        false

      session ->
        {true, session}
    end
  end

  def is_authenticated(user_id, session_value) when is_nil(user_id) or is_nil(session_value) do
    false
  end

  @doc """
  Authenticate
  """
  def authenticate(user_id) when not is_nil(user_id) do
    # Clear old sessions
    UserContext.delete_user_sessions(user_id)

    item =
      UserContext.new_session(%{
        value: get_random_salt(30),
        expire_at: DateTime.utc_now() |> DateTime.add(600, :second),
        user_id: user_id
      })

    case UserContext.create_user_session(item) do
      {:ok, session} ->
        {:success, session}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

  def authenticate(user_id) when is_nil(user_id) do
    {:error, "Invalid User ID"}
  end

  @doc """
  Logout
  """
  def logout(user_id) when not is_nil(user_id) do
    # Clear old sessions
    UserContext.delete_user_sessions(user_id)
  end

  def logout(user_id) when is_nil(user_id) do
    nil
  end

  @doc """
  Get User By API Key
  """
  def get_user_by_api(api_key) when not is_nil(api_key) do
    case UserContext.get_user_by_api_key(api_key) do
      nil ->
        {:not_found, "Invalid API Key"}

      user ->
        {:ok, user}
    end
  end

  def get_user_by_api(api_key) when is_nil(api_key) do
    {:not_found, "Invalid API Key"}
  end
end
