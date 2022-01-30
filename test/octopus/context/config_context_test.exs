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

      {:ok, result} = ConfigContext.create_config(item)

      assert result.name == "app_name"
      assert result.value == "octopus"
      assert result.uuid != ""
      assert result.id != ""
    end

    # get_config_by_id/1
    test "get_config_by_id/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      {:ok, result} = ConfigContext.create_config(item)

      conf = ConfigContext.get_config_by_id(result.id)

      assert conf.name == "app_name"
      assert conf.value == "octopus"
      assert conf.uuid != ""
      assert conf.id != ""
    end

    # get_config_by_uuid/1
    test "get_config_by_uuid/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      {:ok, result} = ConfigContext.create_config(item)

      conf = ConfigContext.get_config_by_uuid(result.uuid)

      assert conf.name == "app_name"
      assert conf.value == "octopus"
      assert conf.uuid != ""
      assert conf.id != ""
    end

    # get_config_by_name/1
    test "get_config_by_name/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      {:ok, result} = ConfigContext.create_config(item)

      conf = ConfigContext.get_config_by_name(result.name)

      assert conf.name == "app_name"
      assert conf.value == "octopus"
      assert conf.uuid != ""
      assert conf.id != ""
    end

    # update_config/2
    test "update_config/2 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      {:ok, result} = ConfigContext.create_config(item)

      {:ok, conf} =
        ConfigContext.update_config(result, %{
          value: "timber"
        })

      assert conf.name == "app_name"
      assert conf.value == "timber"
      assert conf.uuid != ""
      assert conf.id != ""
    end

    # delete_config/1
    test "delete_config/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "octopus"
        })

      {:ok, result} = ConfigContext.create_config(item)

      ConfigContext.delete_config(result)
      conf = ConfigContext.get_config_by_name(result.name)

      assert conf == nil
    end
  end
end
