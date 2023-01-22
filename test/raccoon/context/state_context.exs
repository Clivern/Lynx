defmodule Bandit.Context.StateContextTest do
  use ExUnit.Case

  alias Bandit.Context.StateContext

  describe "new_state/1" do
    test "returns a new state" do
      state = StateContext.new_state(%{name: "State 1", value: "Value 1", project_id: 1})

      assert state.name == "State 1"
      assert state.value == "Value 1"
      assert state.project_id == 1
      assert is_binary(state.uuid)
    end
  end

  describe "create_state/1" do
    test "creates a new state" do
      attrs = %{name: "State 1", value: "Value 1", project_id: 1}
      state = StateContext.create_state(attrs)

      assert state.name == "State 1"
      assert state.value == "Value 1"
      assert state.project_id == 1
      assert is_binary(state.uuid)
    end
  end

  describe "get_state_by_id/1" do
    test "returns the state with the given ID" do
      attrs = %{name: "State 1", value: "Value 1", project_id: 1}
      state = StateContext.create_state(attrs)

      result = StateContext.get_state_by_id(state.id)

      assert result == state
    end
  end

  describe "get_state_by_uuid/1" do
    test "returns the state with the given UUID" do
      attrs = %{name: "State 1", value: "Value 1", project_id: 1}
      state = StateContext.create_state(attrs)

      result = StateContext.get_state_by_uuid(state.uuid)

      assert result == state
    end
  end

  describe "get_state_by_name/1" do
    test "returns the state with the given name" do
      attrs = %{name: "State 1", value: "Value 1", project_id: 1}
      state = StateContext.create_state(attrs)

      result = StateContext.get_state_by_name(state.name)

      assert result == state
    end
  end

  describe "get_latest_state_by_project_id/1" do
    test "returns the latest state for the given project ID" do
      attrs1 = %{name: "State 1", value: "Value 1", project_id: 1}
      attrs2 = %{name: "State 2", value: "Value 2", project_id: 1}
      attrs3 = %{name: "State 3", value: "Value 3", project_id: 2}
      state1 = StateContext.create_state(attrs1)
      state2 = StateContext.create_state(attrs2)
      state3 = StateContext.create_state(attrs3)

      result = StateContext.get_latest_state_by_project_id(1)

      assert result == state2
    end
  end

  describe "update_state/2" do
    test "updates the state with the given attributes" do
      attrs = %{name: "State 1", value: "Value 1", project_id: 1}
      state = StateContext.create_state(attrs)

      updated_attrs = %{name: "State 2", value: "Value 2", project_id: 2}
      updated_state = StateContext.update_state(state, updated_attrs)

      assert updated_state.name == "State 2"
      assert updated_state.value == "Value 2"
      assert updated_state.project_id == 2
      assert updated_state.uuid == state.uuid
    end
  end

  describe "delete_state/1" do
    test "deletes the given state" do
      attrs = %{name: "State 1", value: "Value 1", project_id: 1}
      state = StateContext.create_state(attrs)

      StateContext.delete_state(state)

      assert StateContext.get_state_by_id(state.id) == nil
    end
  end

  describe "get_states/0" do
    test "returns all states" do
      attrs1 = %{name: "State 1", value: "Value 1", project_id: 1}
      attrs2 = %{name: "State 2", value: "Value 2", project_id: 2}
      state1 = StateContext.create_state(attrs1)
      state2 = StateContext.create_state(attrs2)

      result = StateContext.get_states()

      assert result == [state1, state2]
    end
  end

  describe "get_states/2" do
    test "returns the states with the given offset and limit" do
      attrs1 = %{name: "State 1", value: "Value 1", project_id: 1}
      attrs2 = %{name: "State 2", value: "Value 2", project_id: 2}
      attrs3 = %{name: "State 3", value: "Value 3", project_id: 3}
      state1 = StateContext.create_state(attrs1)
      state2 = StateContext.create_state(attrs2)
      state3 = StateContext.create_state(attrs3)

      result = StateContext.get_states(1, 1)

      assert result == [state2]
    end
  end

  describe "create_state_meta/1" do
    test "creates a new state meta" do
      attrs = %{key: "foo", value: "bar", state_id: 1}
      state_meta = StateContext.create_state_meta(attrs)

      assert state_meta.key == "foo"
      assert state_meta.value == "bar"
      assert state_meta.state_id == 1
    end
  end

  describe "get_state_meta_by_id/1" do
    test "returns the state meta with the given ID" do
      attrs = %{key: "foo", value: "bar", state_id: 1}
      state_meta = StateContext.create_state_meta(attrs)

      result = StateContext.get_state_meta_by_id(state_meta.id)

      assert result == state_meta
    end
  end

  describe "update_state_meta/2" do
    test "updates the state meta with the given attributes" do
      attrs = %{key: "foo", value: "bar", state_id: 1}
      state_meta = StateContext.create_state_meta(attrs)

      updated_attrs = %{key: "baz", value: "qux", state_id: 2}
      updated_state_meta = StateContext.update_state_meta(state_meta, updated_attrs)

      assert updated_state_meta.key == "baz"
      assert updated_state_meta.value == "qux"
      assert updated_state_meta.state_id == 2
    end
  end
end
