defmodule Campfire.Context.LockContextTest do
  use ExUnit.Case

  alias Campfire.Context.LockContext

  describe "new_lock/1" do
    test "returns a new lock" do
      lock =
        LockContext.new_lock(%{
          project_id: 1,
          uuid: "foo",
          operation: "bar",
          info: "baz",
          who: "qux",
          version: "1.0.0",
          path: "/tmp",
          is_active: true
        })

      assert lock.project_id == 1
      assert lock.uuid == "foo"
      assert lock.operation == "bar"
      assert lock.info == "baz"
      assert lock.who == "qux"
      assert lock.version == "1.0.0"
      assert lock.path == "/tmp"
      assert lock.is_active == true
    end
  end

  describe "create_lock/1" do
    test "creates a new lock" do
      attrs = %{
        project_id: 1,
        uuid: "foo",
        operation: "bar",
        info: "baz",
        who: "qux",
        version: "1.0.0",
        path: "/tmp",
        is_active: true
      }

      lock = LockContext.create_lock(attrs)

      assert lock.project_id == 1
      assert lock.uuid == "foo"
      assert lock.operation == "bar"
      assert lock.info == "baz"
      assert lock.who == "qux"
      assert lock.version == "1.0.0"
      assert lock.path == "/tmp"
      assert lock.is_active == true
    end
  end

  describe "get_lock_by_id/1" do
    test "returns the lock with the given ID" do
      attrs = %{
        project_id: 1,
        uuid: "foo",
        operation: "bar",
        info: "baz",
        who: "qux",
        version: "1.0.0",
        path: "/tmp",
        is_active: true
      }

      lock = LockContext.create_lock(attrs)

      result = LockContext.get_lock_by_id(lock.id)

      assert result == lock
    end
  end

  describe "get_lock_by_uuid/1" do
    test "returns the lock with the given UUID" do
      attrs = %{
        project_id: 1,
        uuid: "foo",
        operation: "bar",
        info: "baz",
        who: "qux",
        version: "1.0.0",
        path: "/tmp",
        is_active: true
      }

      lock = LockContext.create_lock(attrs)

      result = LockContext.get_lock_by_uuid(lock.uuid)

      assert result == lock
    end
  end

  describe "get_active_lock_by_project_id/1" do
    test "returns the active lock for the given project ID" do
      attrs1 = %{
        project_id: 1,
        uuid: "foo",
        operation: "bar",
        info: "baz",
        who: "qux",
        version: "1.0.0",
        path: "/tmp",
        is_active: true
      }

      attrs2 = %{
        project_id: 1,
        uuid: "baz",
        operation: "qux",
        info: "quux",
        who: "corge",
        version: "2.0.0",
        path: "/tmp",
        is_active: false
      }

      lock1 = LockContext.create_lock(attrs1)
      lock2 = LockContext.create_lock(attrs2)

      result = LockContext.get_active_lock_by_project_id(1)

      assert result == lock1
    end
  end

  describe "update_lock/2" do
    test "updates the lock with the given attributes" do
      attrs = %{
        project_id: 1,
        uuid: "foo",
        operation: "bar",
        info: "baz",
        who: "qux",
        version: "1.0.0",
        path: "/tmp",
        is_active: true
      }

      lock = LockContext.create_lock(attrs)

      updated_attrs = %{
        project_id: 2,
        uuid: "baz",
        operation: "qux",
        info: "quux",
        who: "corge",
        version: "2.0.0",
        path: "/tmp/foo",
        is_active: false
      }

      updated_lock = LockContext.update_lock(lock, updated_attrs)

      assert updated_lock.project_id == 2
      assert updated_lock.uuid == "baz"
      assert updated_lock.operation == "qux"
      assert updated_lock.info == "quux"
      assert updated_lock.who == "corge"
      assert updated_lock.version == "2.0.0"
      assert updated_lock.path == "/tmp/foo"
      assert updated_lock.is_active == false
    end
  end

  describe "delete_lock/1" do
    test "deletes the given lock" do
      attrs = %{
        project_id: 1,
        uuid: "foo",
        operation: "bar",
        info: "baz",
        who: "qux",
        version: "1.0.0",
        path: "/tmp",
        is_active: true
      }

      lock = LockContext.create_lock(attrs)

      LockContext.delete_lock(lock)

      assert LockContext.get_lock_by_id(lock.id) == nil
    end
  end

  describe "create_lock_meta/1" do
    test "creates a new lock meta" do
      attrs = %{key: "foo", value: "bar", lock_id: 1}
      lock_meta = LockContext.create_lock_meta(attrs)

      assert lock_meta.key == "foo"
      assert lock_meta.value == "bar"
      assert lock_meta.lock_id == 1
    end
  end

  describe "get_lock_meta_by_id/1" do
    test "returns the lock meta with the given ID" do
      attrs = %{key: "foo", value: "bar", lock_id: 1}
      lock_meta = LockContext.create_lock_meta(attrs)

      result = LockContext.get_lock_meta_by_id(lock_meta.id)

      assert result == lock_meta
    end
  end

  describe "update_lock_meta/2" do
    test "updates the lock meta with the given attributes" do
      attrs = %{key: "foo", value: "bar", lock_id: 1}
      lock_meta = LockContext.create_lock_meta(attrs)

      updated_attrs = %{key: "baz", value: "qux"}
      updated_lock_meta = LockContext.update_lock_meta(lock_meta, updated_attrs)

      assert updated_lock_meta.key == "baz"
      assert updated_lock_meta.value == "qux"
      assert updated_lock_meta.lock_id == lock_meta.lock_id
    end
  end

  describe "delete_lock_meta/1" do
    test "deletes the given lock meta" do
      attrs = %{key: "foo", value: "bar", lock_id: 1}
      lock_meta = LockContext.create_lock_meta(attrs)

      LockContext.delete_lock_meta(lock_meta)

      assert LockContext.get_lock_meta_by_id(lock_meta.id) == nil
    end
  end
end
