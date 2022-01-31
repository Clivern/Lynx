# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule CivetWeb.ClientController do
  @moduledoc """
  Client Controller
  """

  use CivetWeb, :controller
  alias Civet.Context.ClientContext
  alias Civet.Service.ValidatorService

  @default_list_limit "10"
  @default_list_offset "0"

  @doc """
  View Client Endpoint
  """
  def index(conn, %{"id" => id}) do
    case ValidatorService.validate_int(id) do
      {_, ""} ->
        client =
          id
          |> ValidatorService.parse_int()
          |> ClientContext.get_client_by_id()

        case client do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "Client with ID #{id} not found"})

          _ ->
            conn
            |> put_status(:ok)
            |> render("index.json", %{client: client})
        end

      :error ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid Client ID"})
    end
  end

  @doc """
  List Clients Endpoint
  """
  def list(conn, params) do
    limit = ValidatorService.get_int(params["limit"], @default_list_limit)
    offset = ValidatorService.get_int(params["offset"], @default_list_offset)
    country = ValidatorService.get_str(params["country"], "")
    gender = ValidatorService.get_str(params["gender"], "")

    render(conn, "list.json", %{
      clients: ClientContext.get_clients(country, gender, offset, limit),
      metadata: %{
        limit: limit,
        offset: offset,
        totalCount: ClientContext.count_clients(country, gender)
      }
    })
  end

  @doc """
  Create Client Endpoint
  """
  def create(conn, params) do
    client =
      ClientContext.new_client(%{
        age: ValidatorService.get_int(params["age"], 18),
        country: ValidatorService.get_str(params["country"], ""),
        gender: ValidatorService.get_str(params["gender"], ""),
        state: ValidatorService.get_str(params["state"], ""),
        username: ValidatorService.get_str(params["username"], ""),
        user_id: ValidatorService.get_int(params["userId"], nil)
      })

    case ClientContext.create_client(client) do
      {:ok, client} ->
        conn
        |> put_status(:created)
        |> render("index.json", %{client: client})

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
  Update Client Endpoint
  """
  def update(conn, params) do
    id = params["id"]

    case ValidatorService.validate_int(id) do
      true ->
        client =
          id
          |> ValidatorService.parse_int()
          |> ClientContext.get_client_by_id()

        case client do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "Client with ID #{id} not found"})

          _ ->
            new_client =
              ClientContext.new_client(%{
                age: ValidatorService.get_int(params["age"], client.age),
                country: ValidatorService.get_str(params["country"], client.country),
                gender: ValidatorService.get_str(params["gender"], client.gender),
                state: ValidatorService.get_str(params["state"], client.state),
                username: ValidatorService.get_str(params["username"], client.username),
                user_id: ValidatorService.get_int(params["userId"], client.user_id)
              })

            case ClientContext.update_client(client, new_client) do
              {:ok, client} ->
                conn
                |> put_status(:ok)
                |> render("index.json", %{client: client})

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
        |> render("error.json", %{error: "Invalid Client ID"})
    end
  end

  @doc """
  Delete Client Endpoint
  """
  def delete(conn, %{"id" => id}) do
    case ValidatorService.validate_int(id) do
      true ->
        client =
          id
          |> ValidatorService.parse_int()
          |> ClientContext.get_client_by_id()

        case client do
          nil ->
            conn
            |> put_status(:not_found)
            |> render("error.json", %{error: "Client with ID #{id} not found"})

          _ ->
            ClientContext.delete_client(client)

            conn
            |> send_resp(:no_content, "")
        end

      false ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{error: "Invalid Client ID"})
    end
  end
end
