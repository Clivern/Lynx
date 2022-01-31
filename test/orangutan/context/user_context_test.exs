# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Context.UserContextTest do
  @moduledoc """
  User Context Test Cases
  """
  use Civet.DataCase
  alias Civet.Context.UserContext, as: UserContext

  describe "user_context" do
    test "new_user/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "admin",
          verified: true
        })

      assert user.age == 20
      assert user.country == "germany"
      assert user.email == "hello@clivern.com"
      assert user.name == "Joe Doe"
      assert user.username == "admin"
      assert user.verified == true
      assert user.state == "berlin"
      assert user.gender == "male"
    end

    test "new_meta/1 test cases" do
      meta =
        UserContext.new_meta(%{
          key: "app_name",
          value: "civet",
          user_id: 1
        })

      assert meta.key == "app_name"
      assert meta.value == "civet"
      assert meta.user_id == 1
    end

    test "create_user/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello1@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello1",
          verified: true
        })

      {status, result} = UserContext.create_user(user)

      assert status == :ok
      assert result.id > 0
      assert result.age == 20
      assert result.country == "germany"
      assert result.email == "hello1@clivern.com"
      assert result.name == "Joe Doe"
      assert result.username == "hello1"
      assert result.verified == true
      assert result.state == "berlin"
      assert result.gender == "male"
      assert UserContext.validate_password("12345678", result.password_hash)
    end

    test "get_user_by_id/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello2@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello2",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      result2 = UserContext.get_user_by_id(result1.id)

      assert result1.id == result2.id
      assert result1.age == result2.age
      assert result1.country == result2.country
      assert result1.email == result2.email
      assert result1.name == result2.name
      assert result1.username == result2.username
      assert result1.verified == result2.verified
      assert result1.state == result2.state
      assert result1.gender == result2.gender
      assert UserContext.validate_password("12345678", result1.password_hash)
      assert UserContext.validate_password("12345678", result2.password_hash)
    end

    test "get_user_by_username/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello3@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello3",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      result2 = UserContext.get_user_by_username(result1.username)

      assert result1.id == result2.id
      assert result1.age == result2.age
      assert result1.country == result2.country
      assert result1.email == result2.email
      assert result1.name == result2.name
      assert result1.username == result2.username
      assert result1.verified == result2.verified
      assert result1.state == result2.state
      assert result1.gender == result2.gender
      assert UserContext.validate_password("12345678", result1.password_hash)
      assert UserContext.validate_password("12345678", result2.password_hash)
    end

    test "get_user_by_email/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello4@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello4",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      result2 = UserContext.get_user_by_email(result1.email)

      assert result1.id == result2.id
      assert result1.age == result2.age
      assert result1.country == result2.country
      assert result1.email == result2.email
      assert result1.name == result2.name
      assert result1.username == result2.username
      assert result1.verified == result2.verified
      assert result1.state == result2.state
      assert result1.gender == result2.gender
      assert UserContext.validate_password("12345678", result1.password_hash)
      assert UserContext.validate_password("12345678", result2.password_hash)
    end

    test "count_users/2 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello5@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello5",
          verified: true
        })

      UserContext.create_user(user)

      assert UserContext.count_users("germany", "male") == 1
      assert UserContext.count_users("germany", "female") == 0
      assert UserContext.count_users("netherlands", "male") == 0
    end

    test "get_users/0 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello6@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello6",
          verified: true
        })

      UserContext.create_user(user)
      users = UserContext.get_users()
      assert length(users) == 1

      for result <- users do
        assert result.id > 0
        assert result.age == 20
        assert result.country == "germany"
        assert result.email == "hello6@clivern.com"
        assert result.name == "Joe Doe"
        assert result.username == "hello6"
        assert result.verified == true
        assert result.state == "berlin"
        assert result.gender == "male"
        assert UserContext.validate_password("12345678", result.password_hash)
      end
    end

    test "get_users/4 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello7@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello7",
          verified: false
        })

      UserContext.create_user(user)
      users = UserContext.get_users("germany", "male", 0, 10)
      assert length(users) == 1

      for result <- users do
        assert result.id > 0
        assert result.age == 20
        assert result.country == "germany"
        assert result.email == "hello7@clivern.com"
        assert result.name == "Joe Doe"
        assert result.username == "hello7"
        assert result.verified == false
        assert result.state == "berlin"
        assert result.gender == "male"
        assert UserContext.validate_password("12345678", result.password_hash)
      end

      users = UserContext.get_users("germany", "male", 1, 10)
      assert length(users) == 0

      users = UserContext.get_users("germany", "female", 0, 10)
      assert length(users) == 0

      users = UserContext.get_users("france", "male", 0, 10)
      assert length(users) == 0
    end

    test "delete_user/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello8@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello8",
          verified: false
        })

      {status, result} = UserContext.create_user(user)

      assert status == :ok

      users = UserContext.get_users("germany", "male", 0, 10)
      assert length(users) == 1

      UserContext.delete_user(result)

      users = UserContext.get_users("germany", "male", 0, 10)
      assert length(users) == 0
    end

    test "create_user_meta/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello4@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello4",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      meta =
        UserContext.new_meta(%{
          key: "app_name",
          value: "civet",
          user_id: result1.id
        })

      {status, result2} = UserContext.create_user_meta(meta)

      assert status == :ok
      assert result2.id > 0
      assert result2.key == "app_name"
      assert result2.value == "civet"
      assert result2.user_id == result1.id

      result3 = UserContext.get_user_meta_by_id(result2.id)

      assert result3.id > 0
      assert result3.key == "app_name"
      assert result3.value == "civet"
      assert result3.user_id == result1.id

      assert UserContext.get_user_meta_by_id(200) == nil
    end

    test "update_user_meta/2 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello4@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello4",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      meta =
        UserContext.new_meta(%{
          key: "app_name",
          value: "civet",
          user_id: result1.id
        })

      {status, result2} = UserContext.create_user_meta(meta)

      assert status == :ok
      assert result2.id > 0
      assert result2.key == "app_name"
      assert result2.value == "civet"
      assert result2.user_id == result1.id

      result3 = UserContext.get_user_meta_by_id(result2.id)

      assert result3.id > 0
      assert result3.key == "app_name"
      assert result3.value == "civet"
      assert result3.user_id == result1.id

      {status, result4} =
        UserContext.update_user_meta(result3, %{
          key: "app_name_new"
        })

      assert status == :ok

      assert result4.id > 0
      assert result4.key == "app_name_new"
      assert result4.value == "civet"
      assert result4.user_id == result1.id
    end

    test "delete_user_meta/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello4@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello4",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      meta =
        UserContext.new_meta(%{
          key: "app_name",
          value: "civet",
          user_id: result1.id
        })

      {status, result2} = UserContext.create_user_meta(meta)

      assert status == :ok
      assert result2.id > 0
      assert result2.key == "app_name"
      assert result2.value == "civet"
      assert result2.user_id == result1.id

      result3 = UserContext.get_user_meta_by_id(result2.id)

      assert result3.id > 0
      assert result3.key == "app_name"
      assert result3.value == "civet"
      assert result3.user_id == result1.id

      UserContext.delete_user_meta(result3)

      assert UserContext.get_user_meta_by_id(result2.id) == nil
    end

    test "get_user_meta_by_key/2 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello4@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello4",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      meta =
        UserContext.new_meta(%{
          key: "app_name",
          value: "civet",
          user_id: result1.id
        })

      {status, result2} = UserContext.create_user_meta(meta)

      assert status == :ok
      assert result2.id > 0
      assert result2.key == "app_name"
      assert result2.value == "civet"
      assert result2.user_id == result1.id

      result3 = UserContext.get_user_meta_by_key(result1.id, "app_name")

      assert result3.id > 0
      assert result3.key == "app_name"
      assert result3.value == "civet"
      assert result3.user_id == result1.id
    end

    test "get_user_metas/1 test cases" do
      user =
        UserContext.new_user(%{
          age: 20,
          country: "germany",
          email: "hello4@clivern.com",
          gender: "male",
          name: "Joe Doe",
          password: "12345678",
          state: "berlin",
          username: "hello4",
          verified: true
        })

      {status, result1} = UserContext.create_user(user)

      assert status == :ok

      meta =
        UserContext.new_meta(%{
          key: "app_name",
          value: "civet",
          user_id: result1.id
        })

      {status, result2} = UserContext.create_user_meta(meta)

      assert status == :ok
      assert result2.id > 0
      assert result2.key == "app_name"
      assert result2.value == "civet"
      assert result2.user_id == result1.id

      result3 = UserContext.get_user_metas(result1.id)
      assert length(result3) == 1
    end
  end
end
