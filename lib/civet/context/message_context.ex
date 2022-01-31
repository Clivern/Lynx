# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.MessageContext do
  @moduledoc """
  Message Context Module
  """

  import Ecto.Query
  alias Civet.Repo
  alias Civet.Model.{MessageMeta, Message}

  # Get a message map
  @doc """
  Get a channel map
  """
  def new_message(message \\ %{}) do
    %{
      content: message.content,
      type: message.type,
      client_id: message.client_id,
      channel_id: message.channel_id,
      room_id: message.room_id,
      uuid: Ecto.UUID.generate()
    }
  end

  # Get a message meta map
  @doc """
  Get a channel map
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      message_id: meta.message_id
    }
  end

  # Create a new message
  @doc """
  Get a channel map
  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  # Count all messages
  @doc """
  Get a channel map
  """
  def count_messages(channel_id, room_id) do
    case {channel_id, room_id} do
      {channel_id, room_id} when channel_id != "" and room_id != "" ->
        from(u in Message,
          select: count(u.id),
          where: u.channel_id == ^channel_id,
          where: u.room_id == ^room_id
        )
        |> Repo.one()

      {channel_id, room_id} when channel_id == "" and room_id == "" ->
        from(u in Message,
          select: count(u.id)
        )
        |> Repo.one()

      {channel_id, room_id} when channel_id != "" and room_id == "" ->
        from(u in Message,
          select: count(u.id),
          where: u.channel_id == ^channel_id
        )
        |> Repo.one()

      {channel_id, room_id} when channel_id == "" and room_id != "" ->
        from(u in Message,
          select: count(u.id),
          where: u.room_id == ^room_id
        )
        |> Repo.one()
    end
  end

  # Retrieve a message by ID
  @doc """
  Get a channel map
  """
  def get_message_by_id(id) do
    Repo.get(Message, id)
  end

  # Get message by uuid
  @doc """
  Get a channel map
  """
  def get_message_by_uuid(uuid) do
    from(
      u in Message,
      where: u.uuid == ^uuid
    )
    |> Repo.one()
  end

  # Update a message
  @doc """
  Get a channel map
  """
  def update_message(message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  # Delete a message
  @doc """
  Get a channel map
  """
  def delete_message(message) do
    Repo.delete(message)
  end

  # Retrieve all messages
  @doc """
  Get a channel map
  """
  def get_messages() do
    Repo.all(Message)
  end

  # Retrieve messages
  @doc """
  Get a channel map
  """
  def get_messages(channel_id, room_id, offset, limit) do
    case {channel_id, room_id, offset, limit} do
      {channel_id, room_id, offset, limit} when channel_id != "" and room_id != "" ->
        from(u in Message,
          where: u.channel_id == ^channel_id,
          where: u.room_id == ^room_id,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {channel_id, room_id, offset, limit} when channel_id == "" and room_id == "" ->
        from(u in Message,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {channel_id, room_id, offset, limit} when channel_id != "" and room_id == "" ->
        from(u in Message,
          where: u.channel_id == ^channel_id,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {channel_id, room_id, offset, limit} when channel_id == "" and room_id != "" ->
        from(u in Message,
          where: u.room_id == ^room_id,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()
    end
  end

  # Create a new message meta attribute
  @doc """
  Get a channel map
  """
  def create_message_meta(attrs \\ %{}) do
    %MessageMeta{}
    |> MessageMeta.changeset(attrs)
    |> Repo.insert()
  end

  # Retrieve a message meta attribute by ID
  @doc """
  Get a channel map
  """
  def get_message_meta_by_id(id) do
    Repo.get(MessageMeta, id)
  end

  # Update a message meta attribute
  @doc """
  Get a channel map
  """
  def update_message_meta(message_meta, attrs) do
    MessageMeta.changeset(message_meta, attrs)
    |> Repo.update()
  end

  # Delete a message meta attribute
  @doc """
  Get a channel map
  """
  def delete_message_meta(message_meta) do
    Repo.delete(message_meta)
  end

  # Get message meta by message and key
  @doc """
  Get a channel map
  """
  def get_message_meta_by_key(message_id, meta_key) do
    from(
      u in MessageMeta,
      where: u.message_id == ^message_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  # Get message metas
  @doc """
  Get a channel map
  """
  def get_message_metas(message_id) do
    from(
      u in MessageMeta,
      where: u.message_id == ^message_id
    )
    |> Repo.all()
  end
end
