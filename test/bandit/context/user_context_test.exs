# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Context.UserContextTest do
  @moduledoc """
  User Context Test Cases
  """

  use ExUnit.Case

  alias Bandit.Context.UserContext
  alias Bandit.Context.TeamContext

  # Init
  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Bandit.Repo)
  end

  # Test Cases
  describe "new_user/1" do
    test "test new_user" do
      user =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      assert user.email == "hello@clivern.com"
      assert user.name == "Clivern"
      assert user.password_hash == "27hd7wh2"
      assert user.verified == true
      assert user.role == "super"
      assert user.api_key == "x-x-x-x-x"
      assert is_binary(user.uuid) == true
    end
  end

  describe "new_meta/1" do
    test "test new_meta" do
      meta =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: 1
        })

      assert meta.user_id == 1
      assert meta.key == "meta_key"
      assert meta.value == "meta_value"
    end
  end

  describe "new_session/1" do
    test "test new_session" do
      session =
        UserContext.new_session(%{
          expire_at: "expire_at",
          value: "meta_value",
          user_id: 1
        })

      assert session.user_id == 1
      assert session.expire_at == "expire_at"
      assert session.value == "meta_value"
    end
  end

  describe "create_user/1" do
    test "test create_user" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)
    end
  end

  describe "get_user_by_id/1" do
    test "test get_user_by_id" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_id(user.id)

      assert result == user
    end
  end

  describe "get_user_by_uuid/1" do
    test "test get_user_by_uuid" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_uuid(user.uuid)

      assert result == user
    end
  end

  describe "get_user_by_api_key/1" do
    test "test get_user_by_api_key" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_api_key(user.api_key)

      assert result == user
    end
  end

  describe "get_user_by_email/1" do
    test "test get_user_by_email" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_email(user.email)

      assert result == user
    end
  end

  describe "update_user/2" do
    test "test update_user" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      {_, result} = UserContext.update_user(user, %{email: "hi@clivern.com"})

      assert result.email == "hi@clivern.com"
    end
  end

  describe "delete_user/1" do
    test "test delete_user" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      UserContext.delete_user(user)

      assert UserContext.get_user_by_id(user.id) == nil
    end
  end

  describe "get_users/0" do
    test "test get_users" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      assert UserContext.get_users() == [user]
    end
  end

  describe "get_users/2" do
    test "test get_users" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      assert UserContext.get_users(0, 1) == [user]
      assert UserContext.get_users(1, 1) == []
    end
  end

  describe "count_users/0" do
    test "test count_users" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      UserContext.create_user(attr)

      assert UserContext.count_users() == 1
    end
  end

  describe "create_user_meta/1" do
    test "test create_user_meta" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {status, meta} = UserContext.create_user_meta(attr)

      assert status == :ok
      assert meta.key == "meta_key"
      assert meta.value == "meta_value"
      assert meta.user_id == user.id
      assert meta.id > 0 == true
    end
  end

  describe "create_user_session/1" do
    test "test create_user_session" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      dt = DateTime.utc_now()

      attr =
        UserContext.new_session(%{
          expire_at: dt,
          value: "session_value",
          user_id: user.id
        })

      {status, session} = UserContext.create_user_session(attr)

      assert status == :ok
      assert session.value == "session_value"
      assert session.user_id == user.id
      assert session.id > 0 == true
    end
  end

  describe "get_user_meta_by_id/1" do
    test "test get_user_meta_by_id" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {status, meta} = UserContext.create_user_meta(attr)

      result = UserContext.get_user_meta_by_id(meta.id)

      assert status == :ok
      assert meta == result
    end
  end

  describe "update_user_meta/2" do
    test "test update_user_meta" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {status, meta} = UserContext.create_user_meta(attr)

      assert status == :ok
      assert meta.key == "meta_key"
      assert meta.value == "meta_value"

      {status, meta} =
        UserContext.update_user_meta(
          meta,
          %{key: "new_meta_key", value: "new_meta_value"}
        )

      assert status == :ok
      assert meta.key == "new_meta_key"
      assert meta.value == "new_meta_value"

      result = UserContext.get_user_meta_by_id(meta.id)

      assert status == :ok
      assert result.key == "new_meta_key"
      assert result.value == "new_meta_value"
    end
  end

  describe "update_user_session/2" do
    test "test update_user_session" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      dt = DateTime.utc_now()

      attr =
        UserContext.new_session(%{
          expire_at: dt,
          value: "session_value",
          user_id: user.id
        })

      {status, session} = UserContext.create_user_session(attr)

      assert status == :ok
      assert session.value == "session_value"
      assert session.user_id == user.id
      assert session.id > 0 == true

      {status, session} = UserContext.update_user_session(session, %{value: "new_session_value"})

      assert status == :ok
      assert session.value == "new_session_value"
      assert session.user_id == user.id
      assert session.id > 0 == true
    end
  end

  describe "delete_user_meta/1" do
    test "test delete_user_meta" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {_, meta} = UserContext.create_user_meta(attr)

      UserContext.delete_user_meta(meta)

      result = UserContext.get_user_meta_by_id(meta.id)

      assert result == nil
    end
  end

  describe "delete_user_session/1" do
    test "test delete_user_session" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_session(%{
          expire_at: DateTime.utc_now(),
          value: "session_value",
          user_id: user.id
        })

      {_, session} = UserContext.create_user_session(attr)

      UserContext.delete_user_session(session)

      result = UserContext.get_user_session_by_id_value(user.id, "session_value")

      assert result == nil
    end
  end

  describe "delete_user_sessions/1" do
    test "test delete_user_sessions" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_session(%{
          expire_at: DateTime.utc_now(),
          value: "session_value",
          user_id: user.id
        })

      UserContext.create_user_session(attr)

      UserContext.delete_user_sessions(user.id)

      result = UserContext.get_user_session_by_id_value(user.id, "session_value")

      assert result == nil
    end
  end

  describe "get_user_meta_by_id_key/2" do
    test "test case" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      UserContext.create_user_meta(attr)

      result = UserContext.get_user_meta_by_id_key(user.id, "meta_key")

      assert result.key == "meta_key"
      assert result.value == "meta_value"
      assert result.user_id == user.id
    end
  end

  describe "get_user_session_by_id_key/2" do
    test "test get_user_session_by_id_key" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_session(%{
          expire_at: DateTime.utc_now(),
          value: "session_value",
          user_id: user.id
        })

      UserContext.create_user_session(attr)

      result = UserContext.get_user_session_by_id_value(user.id, "session_value")

      assert result.value == "session_value"
      assert result.user_id == user.id
    end
  end

  describe "get_user_sessions/1" do
    test "test get_user_sessions" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      dt = DateTime.utc_now()

      attr =
        UserContext.new_session(%{
          expire_at: dt,
          value: "session_value",
          user_id: user.id
        })

      {_, session} = UserContext.create_user_session(attr)

      result = UserContext.get_user_sessions(user.id)

      assert result == [session]

      result = UserContext.get_user_sessions(1000)

      assert result == []
    end
  end

  describe "get_user_metas/1" do
    test "test get_user_metas" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {_, meta} = UserContext.create_user_meta(attr)

      result = UserContext.get_user_metas(user.id)

      assert result == [meta]

      result = UserContext.get_user_metas(1000)

      assert result == []
    end
  end

  describe "add_user_to_team/2" do
    test "test add_user_to_team" do
      attrs =
        TeamContext.new_team(%{
          name: "team_a",
          description: "team_a"
        })

      {status_a, team_a} = TeamContext.create_team(attrs)

      assert status_a == :ok
      assert team_a.name == "team_a"
      assert team_a.description == "team_a"
      assert is_binary(team_a.uuid)

      attrs =
        TeamContext.new_team(%{
          name: "team_b",
          description: "team_b"
        })

      {status_b, team_b} = TeamContext.create_team(attrs)

      assert status_b == :ok
      assert team_b.name == "team_b"
      assert team_b.description == "team_b"
      assert is_binary(team_b.uuid)

      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      {status1, result1} = UserContext.add_user_to_team(user.id, team_a.id)
      {status2, result2} = UserContext.add_user_to_team(user.id, team_b.id)

      assert status1 == :ok
      assert status2 == :ok

      assert result1.user_id == user.id
      assert result2.user_id == user.id

      assert result1.team_id == team_a.id
      assert result2.team_id == team_b.id

      result = UserContext.get_user_teams(user.id)

      assert result == [team_a, team_b]

      assert UserContext.get_user_teams(10000) == []
    end
  end

  describe "remove_user_from_team/2" do
    test "test remove_user_from_team" do
      attrs =
        TeamContext.new_team(%{
          name: "team_a",
          description: "team_a"
        })

      {status_a, team_a} = TeamContext.create_team(attrs)

      assert status_a == :ok
      assert team_a.name == "team_a"
      assert team_a.description == "team_a"
      assert is_binary(team_a.uuid)

      attrs =
        TeamContext.new_team(%{
          name: "team_b",
          description: "team_b"
        })

      {status_b, team_b} = TeamContext.create_team(attrs)

      assert status_b == :ok
      assert team_b.name == "team_b"
      assert team_b.description == "team_b"
      assert is_binary(team_b.uuid)

      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      {status1, result1} = UserContext.add_user_to_team(user.id, team_a.id)
      {status2, result2} = UserContext.add_user_to_team(user.id, team_b.id)

      assert status1 == :ok
      assert status2 == :ok

      assert result1.user_id == user.id
      assert result2.user_id == user.id

      assert result1.team_id == team_a.id
      assert result2.team_id == team_b.id

      # Remove user from team a
      UserContext.remove_user_from_team(user.id, team_a.id)

      result = UserContext.get_user_teams(user.id)

      assert result == [team_b]

      assert UserContext.get_user_teams(10000) == []
    end
  end

  describe "remove_user_from_team_by_uuid/1" do
    test "test remove_user_from_team_by_uuid" do
      attrs =
        TeamContext.new_team(%{
          name: "team_a",
          description: "team_a"
        })

      {status_a, team_a} = TeamContext.create_team(attrs)

      assert status_a == :ok
      assert team_a.name == "team_a"
      assert team_a.description == "team_a"
      assert is_binary(team_a.uuid)

      attrs =
        TeamContext.new_team(%{
          name: "team_b",
          description: "team_b"
        })

      {status_b, team_b} = TeamContext.create_team(attrs)

      assert status_b == :ok
      assert team_b.name == "team_b"
      assert team_b.description == "team_b"
      assert is_binary(team_b.uuid)

      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      {status1, result1} = UserContext.add_user_to_team(user.id, team_a.id)
      {status2, result2} = UserContext.add_user_to_team(user.id, team_b.id)

      assert status1 == :ok
      assert status2 == :ok

      assert result1.user_id == user.id
      assert result2.user_id == user.id

      assert result1.team_id == team_a.id
      assert result2.team_id == team_b.id

      UserContext.remove_user_from_team_by_uuid(result1.uuid)

      result = UserContext.get_user_teams(user.id)

      assert result == [team_b]

      assert UserContext.get_user_teams(10000) == []
    end
  end

  describe "get_user_teams/1" do
    test "test get_user_teams" do
      attrs =
        TeamContext.new_team(%{
          name: "team_a",
          description: "team_a"
        })

      {status_a, team_a} = TeamContext.create_team(attrs)

      assert status_a == :ok
      assert team_a.name == "team_a"
      assert team_a.description == "team_a"
      assert is_binary(team_a.uuid)

      attrs =
        TeamContext.new_team(%{
          name: "team_b",
          description: "team_b"
        })

      {status_b, team_b} = TeamContext.create_team(attrs)

      assert status_b == :ok
      assert team_b.name == "team_b"
      assert team_b.description == "team_b"
      assert is_binary(team_b.uuid)

      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      {status1, result1} = UserContext.add_user_to_team(user.id, team_a.id)
      {status2, result2} = UserContext.add_user_to_team(user.id, team_b.id)

      assert status1 == :ok
      assert status2 == :ok

      assert result1.user_id == user.id
      assert result2.user_id == user.id

      assert result1.team_id == team_a.id
      assert result2.team_id == team_b.id

      # Remove user from team a
      UserContext.remove_user_from_team(user.id, team_a.id)

      result = UserContext.get_user_teams(user.id)

      assert result == [team_b]

      assert UserContext.get_user_teams(10000) == []
    end
  end

  describe "get_team_users/1" do
    test "test get_team_users" do
      attrs =
        TeamContext.new_team(%{
          name: "team_a",
          description: "team_a"
        })

      {status_a, team_a} = TeamContext.create_team(attrs)

      assert status_a == :ok
      assert team_a.name == "team_a"
      assert team_a.description == "team_a"
      assert is_binary(team_a.uuid)

      attrs =
        TeamContext.new_team(%{
          name: "team_b",
          description: "team_b"
        })

      {status_b, team_b} = TeamContext.create_team(attrs)

      assert status_b == :ok
      assert team_b.name == "team_b"
      assert team_b.description == "team_b"
      assert is_binary(team_b.uuid)

      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      {status1, result1} = UserContext.add_user_to_team(user.id, team_a.id)
      {status2, result2} = UserContext.add_user_to_team(user.id, team_b.id)

      assert status1 == :ok
      assert status2 == :ok

      assert result1.user_id == user.id
      assert result2.user_id == user.id

      assert result1.team_id == team_a.id
      assert result2.team_id == team_b.id

      result = UserContext.get_team_users(team_a.id)

      assert result == [user]

      result = UserContext.get_team_users(team_b.id)

      assert result == [user]

      assert UserContext.get_team_users(10000) == []
    end
  end

  describe "count_team_users/1" do
    test "test count_team_users" do
      attrs =
        TeamContext.new_team(%{
          name: "team_a",
          description: "team_a"
        })

      {status_a, team_a} = TeamContext.create_team(attrs)

      assert status_a == :ok
      assert team_a.name == "team_a"
      assert team_a.description == "team_a"
      assert is_binary(team_a.uuid)

      attrs =
        TeamContext.new_team(%{
          name: "team_b",
          description: "team_b"
        })

      {status_b, team_b} = TeamContext.create_team(attrs)

      assert status_b == :ok
      assert team_b.name == "team_b"
      assert team_b.description == "team_b"
      assert is_binary(team_b.uuid)

      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      UserContext.add_user_to_team(user.id, team_a.id)
      UserContext.add_user_to_team(user.id, team_b.id)

      assert UserContext.count_team_users(team_a.id) == 1
      assert UserContext.count_team_users(team_b.id) == 1
      assert UserContext.count_team_users(100) == 0
    end
  end

  describe "validate_user_id/1" do
    test "test validate_user_id" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      assert UserContext.validate_user_id(user.id) == true
    end
  end

  describe "validate_team_id/1" do
    test "test validate_team_id" do
      attrs =
        TeamContext.new_team(%{
          name: "Team 2",
          description: "Description 2"
        })

      {status, team} = TeamContext.create_team(attrs)

      assert status == :ok

      assert team.name == "Team 2"
      assert team.description == "Description 2"
      assert is_binary(team.uuid)

      assert UserContext.validate_team_id(team.id) == true
    end
  end
end
