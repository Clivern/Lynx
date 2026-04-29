# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.EndpointConfigTest do
  use ExUnit.Case, async: false

  alias LynxWeb.EndpointConfig

  setup do
    original = System.get_env("APP_HTTP_MAX_BODY_LENGTH")

    on_exit(fn ->
      case original do
        nil -> System.delete_env("APP_HTTP_MAX_BODY_LENGTH")
        value -> System.put_env("APP_HTTP_MAX_BODY_LENGTH", value)
      end
    end)

    :ok
  end

  describe "max_body_length/0" do
    test "defaults to 8MB when APP_HTTP_MAX_BODY_LENGTH is unset" do
      System.delete_env("APP_HTTP_MAX_BODY_LENGTH")
      assert EndpointConfig.max_body_length() == 8_000_000
    end

    test "returns the parsed integer when APP_HTTP_MAX_BODY_LENGTH is set" do
      System.put_env("APP_HTTP_MAX_BODY_LENGTH", "33554432")
      assert EndpointConfig.max_body_length() == 33_554_432
    end

    test "falls back to the default when APP_HTTP_MAX_BODY_LENGTH is an empty string" do
      System.put_env("APP_HTTP_MAX_BODY_LENGTH", "")
      assert EndpointConfig.max_body_length() == 8_000_000
    end

    test "raises when APP_HTTP_MAX_BODY_LENGTH is not numeric" do
      System.put_env("APP_HTTP_MAX_BODY_LENGTH", "not-a-number")
      assert_raise ArgumentError, fn -> EndpointConfig.max_body_length() end
    end
  end
end
