# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.ChannelContext do
  @moduledoc """
  Channel Context Module
  """

  import Ecto.Query
  alias Civet.Repo
  alias Civet.Model.{ChannelMeta, Channel}

  @doc """
  Get a channel map
  """
  def new_channel(channel \\ %{}) do
    %{
      first_user_id: channel.first_user_id,
      second_user_id: channel.second_user_id,
      uuid: Ecto.UUID.generate()
    }
  end

  @doc """
  Get a channel meta map
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      channel_id: meta.channel_id
    }
  end

  @doc """
  Create a new channel
  """
  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a channel by ID
  """
  def get_channel_by_id(id) do
    Repo.get(Channel, id)
  end

  @doc """
  Get channel by UUID
  """
  def get_channel_by_uuid(uuid) do
    from(
      u in Channel,
      where: u.uuid == ^uuid
    )
    |> Repo.one()
  end

  @doc """
  Get channel by users
  """
  def get_channel_by_users(first_user_id, second_user_id) do
    from(
      u in Channel,
      where: u.first_user_id == ^first_user_id,
      where: u.second_user_id == ^second_user_id
    )
    |> Repo.one()
  end

  @doc """
  Update a channel
  """
  def update_channel(channel, attrs) do
    channel
    |> Channel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a channel
  """
  def delete_channel(channel) do
    Repo.delete(channel)
  end

  @doc """
  Retrieve all channels
  """
  def get_channels() do
    Repo.all(Channel)
  end

  @doc """
  Retrieve channels
  """
  def get_channels(offset, limit) do
    from(u in Channel,
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Create a new channel meta attribute
  """
  def create_channel_meta(attrs \\ %{}) do
    %ChannelMeta{}
    |> ChannelMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a channel meta attribute by ID
  """
  def get_channel_meta_by_id(id) do
    Repo.get(ChannelMeta, id)
  end

  @doc """
  Update a channel meta attribute
  """
  def update_channel_meta(channel_meta, attrs) do
    ChannelMeta.changeset(channel_meta, attrs)
    |> Repo.update()
  end

  @doc """
  Delete a channel meta attribute
  """
  def delete_channel_meta(channel_meta) do
    Repo.delete(channel_meta)
  end

  @doc """
  Get channel meta by channel and key
  """
  def get_channel_meta_by_key(channel_id, meta_key) do
    from(
      u in ChannelMeta,
      where: u.channel_id == ^channel_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get channel metas
  """
  def get_channel_metas(channel_id) do
    from(
      u in ChannelMeta,
      where: u.channel_id == ^channel_id
    )
    |> Repo.all()
  end
end
