# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.ClientContextTest do
  @moduledoc """
  Client Context Test Cases
  """
  use Civet.DataCase
  alias Civet.Context.ClientContext, as: ClientContext

  describe "client_context" do
    test "new_client/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      assert client.age == 30
      assert client.country == "netherlands"
      assert client.gender == "male"
      assert client.state == "amsterdam"
      assert client.username == "admin"
      assert client.user_id == nil

      {status, result} = ClientContext.create_client(client)

      assert status == :ok
      assert result.age == 30
      assert result.country == "netherlands"
      assert result.gender == "male"
      assert result.state == "amsterdam"
      assert result.username == "admin"
      assert result.user_id == nil
    end

    test "new_meta/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status, result} = ClientContext.create_client(client)

      assert status == :ok

      meta =
        ClientContext.new_meta(%{
          key: "app_name",
          value: "civet",
          client_id: result.id
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.client_id == result.id
    end

    test "get_client_by_id/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status, result1} = ClientContext.create_client(client)

      assert status == :ok

      result2 = ClientContext.get_client_by_id(result1.id)

      assert result2.id > 0
      assert result2.age == 30
      assert result2.country == "netherlands"
      assert result2.gender == "male"
      assert result2.state == "amsterdam"
      assert result2.username == "admin"
      assert result2.user_id == nil
    end

    test "get_client_by_uuid/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status, result1} = ClientContext.create_client(client)

      assert status == :ok

      result2 = ClientContext.get_client_by_uuid(result1.uuid)

      assert result2.id > 0
      assert result2.age == 30
      assert result2.country == "netherlands"
      assert result2.gender == "male"
      assert result2.state == "amsterdam"
      assert result2.username == "admin"
      assert result2.user_id == nil
    end

    test "get_client_by_username/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status, result1} = ClientContext.create_client(client)

      assert status == :ok

      result2 = ClientContext.get_client_by_username(result1.username)

      assert result2.id > 0
      assert result2.age == 30
      assert result2.country == "netherlands"
      assert result2.gender == "male"
      assert result2.state == "amsterdam"
      assert result2.username == "admin"
      assert result2.user_id == nil
    end

    test "count_clients/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status, result1} = ClientContext.create_client(client)

      assert status == :ok

      result2 = ClientContext.count_clients(result1.country, result1.gender)

      assert result2 == 1
    end

    test "create_client_meta/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status1, result1} = ClientContext.create_client(client)

      assert status1 == :ok

      meta =
        ClientContext.new_meta(%{
          key: "app_name",
          value: "civet",
          client_id: result1.id
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.client_id == result1.id

      {status2, result2} = ClientContext.create_client_meta(meta)

      assert status2 == :ok

      assert result2.key == "app_name"
      assert result2.value == "civet"
      assert result2.client_id == result1.id
    end

    test "get_client_meta_by_id/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status1, result1} = ClientContext.create_client(client)

      assert status1 == :ok

      meta =
        ClientContext.new_meta(%{
          key: "app_name",
          value: "civet",
          client_id: result1.id
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.client_id == result1.id

      {status2, result2} = ClientContext.create_client_meta(meta)

      assert status2 == :ok

      result3 = ClientContext.get_client_meta_by_id(result2.id)

      assert result3.key == "app_name"
      assert result3.value == "civet"
      assert result3.client_id == result1.id
    end

    test "update_client_meta/2 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status1, result1} = ClientContext.create_client(client)

      assert status1 == :ok

      meta =
        ClientContext.new_meta(%{
          key: "app_name",
          value: "civet",
          client_id: result1.id
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.client_id == result1.id

      {status2, result2} = ClientContext.create_client_meta(meta)

      assert status2 == :ok

      result3 = ClientContext.get_client_meta_by_id(result2.id)

      ClientContext.update_client_meta(result3, %{
        key: "app_name2"
      })

      result3 = ClientContext.get_client_meta_by_id(result2.id)

      assert result3.key == "app_name2"
      assert result3.value == "civet"
      assert result3.client_id == result1.id
    end

    test "delete_client_meta/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status1, result1} = ClientContext.create_client(client)

      assert status1 == :ok

      meta =
        ClientContext.new_meta(%{
          key: "app_name",
          value: "civet",
          client_id: result1.id
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.client_id == result1.id

      {status2, result2} = ClientContext.create_client_meta(meta)

      assert status2 == :ok

      result3 = ClientContext.get_client_meta_by_id(result2.id)

      ClientContext.update_client_meta(result3, %{
        key: "app_name2"
      })

      result3 = ClientContext.get_client_meta_by_id(result2.id)

      assert result3.key == "app_name2"
      assert result3.value == "civet"
      assert result3.client_id == result1.id
    end

    test "get_client_meta_by_key/2 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status1, result1} = ClientContext.create_client(client)

      assert status1 == :ok

      meta =
        ClientContext.new_meta(%{
          key: "app_name",
          value: "civet",
          client_id: result1.id
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.client_id == result1.id

      {status2, _} = ClientContext.create_client_meta(meta)

      assert status2 == :ok

      result3 = ClientContext.get_client_meta_by_key(result1.id, "app_name")

      assert result3.key == "app_name"
      assert result3.value == "civet"
      assert result3.client_id == result1.id
    end

    test "get_client_metas/1 test cases" do
      client =
        ClientContext.new_client(%{
          age: 30,
          country: "netherlands",
          gender: "male",
          state: "amsterdam",
          username: "admin",
          user_id: nil
        })

      {status1, result1} = ClientContext.create_client(client)

      assert status1 == :ok

      meta =
        ClientContext.new_meta(%{
          key: "app_name",
          value: "civet",
          client_id: result1.id
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.client_id == result1.id

      {status2, _} = ClientContext.create_client_meta(meta)

      assert status2 == :ok

      result3 = ClientContext.get_client_metas(result1.id)

      assert length(result3) == 1
    end
  end
end
