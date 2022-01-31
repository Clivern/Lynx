# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.UserContext do
  @moduledoc """
  User Context Module
  """

  require Argon2
  import Ecto.Query
  alias Civet.Repo
  alias Civet.Model.{UserMeta, User}

  @doc """
  Get a user map
  """
  def new_user(user \\ %{}) do
    %{
      age: user.age,
      country: user.country,
      email: user.email,
      gender: user.gender,
      last_seen: DateTime.utc_now(),
      name: user.name,
      password_hash: Argon2.hash_pwd_salt(user.password),
      state: user.state,
      username: user.username,
      verified: user.verified
    }
  end

  @doc """
  Get a user meta map
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      user_id: meta.user_id
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
  Count all users
  """
  def count_users(country, gender) do
    case {country, gender} do
      {country, gender} when country != "" and gender != "" ->
        from(u in User,
          select: count(u.id),
          where: u.country == ^country,
          where: u.gender == ^gender
        )
        |> Repo.one()

      {country, gender} when country == "" and gender == "" ->
        from(u in User,
          select: count(u.id)
        )
        |> Repo.one()

      {country, gender} when country != "" and gender == "" ->
        from(u in User,
          select: count(u.id),
          where: u.country == ^country
        )
        |> Repo.one()

      {country, gender} when country == "" and gender != "" ->
        from(u in User,
          select: count(u.id),
          where: u.gender == ^gender
        )
        |> Repo.one()
    end
  end

  @doc """
  Retrieve a user by ID
  """
  def get_user_by_id(id) do
    Repo.get(User, id)
  end

  @doc """
  Get user by username
  """
  def get_user_by_username(username) do
    from(
      u in User,
      where: u.username == ^username
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
  def get_users(country, gender, offset, limit) do
    case {country, gender, offset, limit} do
      {country, gender, offset, limit} when country != "" and gender != "" ->
        from(u in User,
          where: u.country == ^country,
          where: u.gender == ^gender,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, gender, offset, limit} when country == "" and gender == "" ->
        from(u in User,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, gender, offset, limit} when country != "" and gender == "" ->
        from(u in User,
          where: u.country == ^country,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, gender, offset, limit} when country == "" and gender != "" ->
        from(u in User,
          where: u.gender == ^gender,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()
    end
  end

  @doc """
  Create a new user meta attribute
  """
  def create_user_meta(attrs \\ %{}) do
    %UserMeta{}
    |> UserMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a user meta attribute by ID
  """
  def get_user_meta_by_id(id) do
    Repo.get(UserMeta, id)
  end

  @doc """
  Update a user meta attribute
  """
  def update_user_meta(user_meta, attrs) do
    UserMeta.changeset(user_meta, attrs)
    |> Repo.update()
  end

  @doc """
  Delete a user meta attribute
  """
  def delete_user_meta(user_meta) do
    Repo.delete(user_meta)
  end

  @doc """
  Validate a user password
  """
  def validate_password(plain_password, hash) do
    Argon2.verify_pass(plain_password, hash)
  end

  @doc """
  Get user meta by user and key
  """
  def get_user_meta_by_key(user_id, meta_key) do
    from(
      u in UserMeta,
      where: u.user_id == ^user_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
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
