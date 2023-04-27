# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Service.OIDCService do
  @moduledoc """
  OIDC Service
  """
  @chars "abcdefghijklmnopqrstuvwxyz0123456789"

  @doc """
  Get Authentication URL

  ## Parameters

      - authorize_url: The authorization URL
      - scopes: The scopes
      - response_type: the response type
      - client_id: The client id
      - redirect_uri: The redirect URL
  """
  def get_auth_link(authorize_url, scopes, response_type, client_id, redirect_uri) do
    state = get_random_string(34)
    redirect_uri = URI.encode_www_form(redirect_uri)
    scopes = String.replace(scopes, " ", "+")

    "#{authorize_url}?scope=#{scopes}&response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}"
  end

  @doc """
  Fetch Access Token

  ## Parameters

    - token_url: The token URL
    - client_id: The client id
    - client_secret: The client secret
    - redirect_uri: The redirect URL
    - code: The authentication code received from auth provider
  """
  def fetch_access_token(token_url, client_id, client_secret, redirect_uri, code) do
    body =
      {:form,
       [
         {"grant_type", "authorization_code"},
         {"code", code},
         {"redirect_uri", redirect_uri}
       ]}

    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]

    case HTTPoison.post(token_url, body, headers,
           hackney: [basic_auth: {client_id, client_secret}]
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        # Handle the successful response
        response = Jason.decode!(body)
        {:ok, response}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        # Handle other status codes
        {:error, "Invalid status code #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        # Handle errors
        {:error, reason}
    end
  end

  @doc """
  Fetch User Info

  ## Parameters

    - user_info_url: The user info URL.
    - access_token: The access token received from fetch_access_token method
  """
  def fetch_user_info(user_info_url, access_token) do
    headers = [
      {"Authorization", "Bearer #{access_token}"}
    ]

    case HTTPoison.get(user_info_url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        # Handle the successful response
        response = Jason.decode!(body)
        {:ok, response}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        # Handle other status codes
        {:error, "Invalid status code #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        # Handle errors
        {:error, reason}
    end
  end

  defp get_random_string(length) do
    @chars
    |> String.to_charlist()
    |> Enum.take_random(length)
    |> List.to_string()
  end
end
