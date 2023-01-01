# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Raccoon.Module.UserModule do
  @moduledoc """
  User Module
  """

  alias Raccoon.Context.UserContext
  alias Raccoon.Service.ValidatorService
  alias Raccoon.Service.AuthService

  @doc """
  Get User By ID
  """
  def get_user_by_id(user_id) do
    case UserContext.get_user_by_id(user_id) do
      nil ->
        {:not_found, nil}

      user ->
        {:ok, user}
    end
  end

  @doc """
  Count Users
  """
  def count_users() do
    UserContext.count_users()
  end

  @doc """
  Get Users
  """
  def get_users(offset, limit) do
    UserContext.get_users(offset, limit)
  end

  @doc """
  Create User
  """
  def create_user(params \\ %{}) do
    user =
      UserContext.new_user(%{
        email: params[:email],
        name: params[:name],
        password_hash:
          AuthService.hash_password(
            params[:password],
            params[:app_key]
          ),
        verified: false,
        api_key: params[:api_key],
        role: params[:role],
        last_seen: DateTime.utc_now()
      })

    case UserContext.create_user(user) do
      {:ok, user} ->
        {:ok, user}

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        {:error, Enum.at(messages, 0)}
    end
  end

  @doc """
  Update User
  """
  def update_user(params \\ %{}) do
    id = params[:id]

    case ValidatorService.validate_int(id) do
      true ->
        user =
          id
          |> ValidatorService.parse_int()
          |> UserContext.get_user_by_id()

        case user do
          nil ->
            {:not_found, "User with ID #{id} not found"}

          _ ->
            new_user =
              UserContext.new_user(%{
                email: ValidatorService.get_str(params[:email], user.email),
                name: ValidatorService.get_str(params[:name], user.name),
                api_key: ValidatorService.get_str(params[:api_key], user.api_key),
                role: ValidatorService.get_str(params[:role], user.role)
              })

            case UserContext.update_user(user, new_user) do
              {:ok, user} ->
                {:ok, user}

              {:error, changeset} ->
                messages =
                  changeset.errors()
                  |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

                {:error, Enum.at(messages, 0)}
            end
        end

      false ->
        {:error, "Invalid User ID"}
    end
  end

  @doc """
  Delete User
  """
  def delete_user(id) do
    case ValidatorService.validate_int(id) do
      true ->
        user =
          id
          |> ValidatorService.parse_int()
          |> UserContext.get_user_by_id()

        case user do
          nil ->
            {:not_found, "User with ID #{id} not found"}

          _ ->
            UserContext.delete_user(user)
            {:ok, "User with ID #{id} deleted successfully"}
        end

      false ->
        {:error, "Invalid User ID"}
    end
  end
end
