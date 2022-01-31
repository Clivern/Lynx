# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Octopus.Context.UserContext do
  @moduledoc """
  User Context Module
  """

  import Ecto.Query
  alias Octopus.Repo
  alias Octopus.Model.{UserMeta, User, UserSession}

  @doc """
  Get a new user
  """
  def new_user(user \\ %{}) do
    %{
      email: user.email,
      name: user.name,
      password_hash: user.password_hash,
      verified: user.verified,
      last_seen: user.last_seen,
      role: user.role,
      api_key: user.api_key,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Get a user meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      user_id: meta.user_id
    }
  end

  @doc """
  Get a user session
  """
  def new_session(session \\ %{}) do
    %{
      value: session.value,
      expire_at: session.expire_at,
      user_id: session.user_id
    }
  end

  @doc """
  Create a new user
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a user by ID
  """
  def get_user_by_id(id) do
    Repo.get(User, id)
  end

  @doc """
  Get user by uuid
  """
  def get_user_by_uuid(uuid) do
    from(
      u in User,
      where: u.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Get user by email
  """
  def get_user_by_email(email) do
    from(
      u in User,
      where: u.email == ^email
    )
    |> Repo.one()
  end

  @doc """
  Update a user
  """
  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a user
  """
  def delete_user(user) do
    Repo.delete(user)
  end

  @doc """
  Retrieve all users
  """
  def get_users() do
    Repo.all(User)
  end

  @doc """
  Retrieve users
  """
  def get_users(offset, limit) do
    from(u in User,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Create a new user meta
  """
  def create_user_meta(attrs \\ %{}) do
    %UserMeta{}
    |> UserMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create a new user session
  """
  def create_user_session(attrs \\ %{}) do
    %UserSession{}
    |> UserSession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a user meta by id
  """
  def get_user_meta_by_id(id) do
    Repo.get(UserMeta, id)
  end

  @doc """
  Update a user meta
  """
  def update_user_meta(user_meta, attrs) do
    UserMeta.changeset(user_meta, attrs)
    |> Repo.update()
  end

  @doc """
  Update a user session
  """
  def update_user_session(user_session, attrs) do
    UserSession.changeset(user_session, attrs)
    |> Repo.update()
  end

  @doc """
  Delete a user meta
  """
  def delete_user_meta(user_meta) do
    Repo.delete(user_meta)
  end

  @doc """
  Delete a user session
  """
  def delete_user_session(user_session) do
    Repo.delete(user_session)
  end

  @doc """
  Delete user sessions
  """
  def delete_user_sessions(user_id) do
    from(
      u in UserSession,
      where: u.user_id == ^user_id
    )
    |> Repo.delete_all()
  end

  @doc """
  Get user meta by user id and key
  """
  def get_user_meta_by_id_key(user_id, meta_key) do
    from(
      u in UserMeta,
      where: u.user_id == ^user_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get user session by user id and value
  """
  def get_user_session_by_id_key(user_id, value) do
    from(
      u in UserSession,
      where: u.user_id == ^user_id,
      where: u.value == ^value
    )
    |> Repo.one()
  end

  @doc """
  Get user sessions
  """
  def get_user_sessions(user_id) do
    from(
      u in UserSession,
      where: u.user_id == ^user_id
    )
    |> Repo.all()
  end

  @doc """
  Get user metas
  """
  def get_user_metas(user_id) do
    from(
      u in UserMeta,
      where: u.user_id == ^user_id
    )
    |> Repo.all()
  end
end
