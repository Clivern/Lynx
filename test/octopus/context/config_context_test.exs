# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Octopus.Context.ConfigContextTest do
  @moduledoc """
  Lock Context Test Cases
  """
  use Octopus.DataCase
  alias Octopus.Context.ConfigContext, as: ConfigContext

  describe "config" do
    # new_config/1
    test "new_config/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      assert item.name == "app_name"
      assert item.value == "octopus"
      assert item.uuid != ""
    end

    # create_config/1
    test "create_config/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      result = ConfigContext.create_config(item)

      case result do
        {:ok, co} ->
          assert co.name == "app_name"
          assert co.value == "octopus"
          assert co.uuid != ""
          assert co.id != ""

        _ ->
          nil
      end
    end

    # get_config_by_id/1
    test "get_config_by_id/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      result = ConfigContext.create_config(item)

      case result do
        {:ok, co} ->
          conf = ConfigContext.get_config_by_id(co.id)

          case conf do
            conf ->
              assert conf.name == "app_name"
              assert conf.value == "octopus"
              assert conf.uuid != ""
              assert conf.id != ""
          end

        _ ->
          nil
      end
    end

    # get_config_by_uuid/1
    test "get_config_by_uuid/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      result = ConfigContext.create_config(item)

      case result do
        {:ok, co} ->
          conf = ConfigContext.get_config_by_uuid(co.uuid)

          case conf do
            conf ->
              assert conf.name == "app_name"
              assert conf.value == "octopus"
              assert conf.uuid != ""
              assert conf.id != ""
          end

        _ ->
          nil
      end
    end

    # get_config_by_name/1
    test "get_config_by_name/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      result = ConfigContext.create_config(item)

      case result do
        {:ok, co} ->
          conf = ConfigContext.get_config_by_name(co.name)

          case conf do
            conf ->
              assert conf.name == "app_name"
              assert conf.value == "octopus"
              assert conf.uuid != ""
              assert conf.id != ""
          end

        _ ->
          nil
      end
    end

    # update_config/2
    test "update_config/2 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      result = ConfigContext.create_config(item)

      case result do
        {:ok, co} ->
          conf =
            ConfigContext.update_config(co, %{
              value: "timber"
            })

          case conf do
            {:ok, conf} ->
              assert conf.name == "app_name"
              assert conf.value == "timber"
              assert conf.uuid != ""
              assert conf.id != ""
          end

        _ ->
          nil
      end
    end

    # delete_config/1
    test "delete_config/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      result = ConfigContext.create_config(item)

      case result do
        {:ok, co} ->
          ConfigContext.delete_config(co)
          conf = ConfigContext.get_config_by_name(co.name)
          assert conf == nil

        _ ->
          nil
      end
    end
  end
end
