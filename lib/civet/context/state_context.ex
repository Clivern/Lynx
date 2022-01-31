# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.StateContext do
  @moduledoc """
  State Context Module
  """

  import Ecto.Query
  alias Civet.Repo
  alias Civet.Model.{StateMeta, State}

  @doc """
  Get a client map
  """
  def new_client(client \\ %{}) do
    %{
      age: client.age,
      country: client.country,
      gender: client.gender,
      last_seen: DateTime.utc_now(),
      secret: Ecto.UUID.generate(),
      state: client.state,
      username: client.username,
      uuid: Ecto.UUID.generate(),
      user_id: client.user_id
    }
  end

  @doc """
  Get a client meta map
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      client_id: meta.client_id
    }
  end

  @doc """
  Create a new client
  """
  def create_client(attrs \\ %{}) do
    %State{}
    |> State.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Count all clients
  """
  def count_clients(country, gender) do
    case {country, gender} do
      {country, gender} when country != "" and gender != "" ->
        from(u in State,
          select: count(u.id),
          where: u.country == ^country,
          where: u.gender == ^gender
        )
        |> Repo.one()

      {country, gender} when country == "" and gender == "" ->
        from(u in State,
          select: count(u.id)
        )
        |> Repo.one()

      {country, gender} when country != "" and gender == "" ->
        from(u in State,
          select: count(u.id),
          where: u.country == ^country
        )
        |> Repo.one()

      {country, gender} when country == "" and gender != "" ->
        from(u in State,
          select: count(u.id),
          where: u.gender == ^gender
        )
        |> Repo.one()
    end
  end

  @doc """
  Retrieve a client by ID
  """
  def get_client_by_id(id) do
    Repo.get(State, id)
  end

  @doc """
  Get client by UUID
  """
  def get_client_by_uuid(uuid) do
    from(
      u in State,
      where: u.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Get client by username
  """
  def get_client_by_username(username) do
    from(
      u in State,
      where: u.username == ^username
    )
    |> Repo.one()
  end

  @doc """
  Update a client
  """
  def update_client(client, attrs) do
    client
    |> State.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a client
  """
  def delete_client(client) do
    Repo.delete(client)
  end

  @doc """
  Retrieve all clients
  """
  def get_clients() do
    Repo.all(State)
  end

  @doc """
  Retrieve clients
  """
  def get_clients(country, gender, offset, limit) do
    case {country, gender, offset, limit} do
      {country, gender, offset, limit} when country != "" and gender != "" ->
        from(u in State,
          where: u.country == ^country,
          where: u.gender == ^gender,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, gender, offset, limit} when country == "" and gender == "" ->
        from(u in State,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, gender, offset, limit} when country != "" and gender == "" ->
        from(u in State,
          where: u.country == ^country,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, gender, offset, limit} when country == "" and gender != "" ->
        from(u in State,
          where: u.gender == ^gender,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()
    end
  end

  @doc """
  Create a new client meta attribute
  """
  def create_client_meta(attrs \\ %{}) do
    %StateMeta{}
    |> StateMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a client meta attribute by ID
  """
  def get_client_meta_by_id(id) do
    Repo.get(StateMeta, id)
  end

  @doc """
  Update a client meta attribute
  """
  def update_client_meta(client_meta, attrs) do
    StateMeta.changeset(client_meta, attrs)
    |> Repo.update()
  end

  @doc """
  Delete a client meta attribute
  """
  def delete_client_meta(client_meta) do
    Repo.delete(client_meta)
  end

  @doc """
  Get client meta by client and key
  """
  def get_client_meta_by_key(client_id, meta_key) do
    from(
      u in StateMeta,
      where: u.client_id == ^client_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get client metas
  """
  def get_client_metas(client_id) do
    from(
      u in StateMeta,
      where: u.client_id == ^client_id
    )
    |> Repo.all()
  end
end
