# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.UserController do
  @moduledoc """
  User Controller
  """

  use CivetWeb, :controller
  alias Civet.Context.UserContext
  alias Civet.Service.ValidatorService

  @default_list_limit "10"
  @default_list_offset "0"

  @doc """
  View User Endpoint
  """
  def index(conn, %{"id" => id}) do
    case ValidatorService.validate_int(id) do
      {_, ""} ->
        user =
          id
          |> ValidatorService.parse_int()
          |> UserContext.get_user_by_id()

        case user do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "User with ID #{id} not found"})

          _ ->
            conn
            |> put_status(:ok)
            |> render("index.json", %{user: user})
        end

      :error ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid User ID"})
    end
  end

  @doc """
  List Users Endpoint
  """
  def list(conn, params) do
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)
    country = ValidatorService.get_str(params["country"], "")
    gender = ValidatorService.get_str(params["gender"], "")

    render(conn, "list.json", %{
      users: UserContext.get_users(country, gender, offset, limit),
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: UserContext.count_users(country, gender)
      }
    })
  end

  @doc """
  Create User Endpoint
  """
  def create(conn, params) do
    user =
      UserContext.new_user(%{
        age: ValidatorService.get_int(params["age"], 18),
        country: ValidatorService.get_str(params["country"], ""),
        email: ValidatorService.get_str(params["email"], ""),
        gender: ValidatorService.get_str(params["gender"], ""),
        name: ValidatorService.get_str(params["name"], ""),
        password: ValidatorService.get_str(params["password"], ""),
        state: ValidatorService.get_str(params["state"], ""),
        username: ValidatorService.get_str(params["username"], ""),
        verified: false
      })

    case UserContext.create_user(user) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("index.json", %{user: user})

      {:error, changeset} ->
        messages =
          changeset.errors()
          |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: Enum.at(messages, 0)})
    end
  end

  @doc """
  Update User Endpoint
  """
  def update(conn, params) do
    id = params["id"]

    case ValidatorService.validate_int(id) do
      true ->
        user =
          id
          |> ValidatorService.parse_int()
          |> UserContext.get_user_by_id()

        case user do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "User with ID #{id} not found"})

          _ ->
            new_user =
              UserContext.new_user(%{
                age: ValidatorService.get_int(params["age"], user.age),
                country: ValidatorService.get_str(params["country"], user.country),
                email: ValidatorService.get_str(params["email"], user.email),
                gender: ValidatorService.get_str(params["gender"], user.gender),
                name: ValidatorService.get_str(params["name"], user.name),
                password: ValidatorService.get_str(params["password"], user.password),
                state: ValidatorService.get_str(params["state"], user.state),
                username: ValidatorService.get_str(params["username"], user.username),
                verified: user.verified
              })

            case UserContext.update_user(user, new_user) do
              {:ok, user} ->
                conn
                |> put_status(:ok)
                |> render("index.json", %{user: user})

              {:error, changeset} ->
                messages =
                  changeset.errors()
                  |> Enum.map(fn {field, {message, _options}} -> "#{field}: #{message}" end)

                conn
                |> put_status(:bad_request)
                |> render("error.json", %{error: Enum.at(messages, 0)})
            end
        end

      false ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid User ID"})
    end
  end

  @doc """
  Delete User Endpoint
  """
  def delete(conn, %{"id" => id}) do
    case ValidatorService.validate_int(id) do
      true ->
        user =
          id
          |> ValidatorService.parse_int()
          |> UserContext.get_user_by_id()

        case user do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "User with ID #{id} not found"})

          _ ->
            UserContext.delete_user(user)

            conn
            |> send_resp(:no_content, "")
        end

      false ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid User ID"})
    end
  end
end
