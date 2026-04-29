# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.EndpointTest do
  use ExUnit.Case, async: false

  alias Lynx.Config

  describe ":http_max_body_length endpoint config" do
    test "defaults to 8 MB so existing deployments are unaffected" do
      assert Application.get_env(:lynx, LynxWeb.Endpoint)[:http_max_body_length] == 8_000_000
    end

    test "Lynx.Config.max_body_length/0 reads from app env at runtime" do
      original = Application.get_env(:lynx, LynxWeb.Endpoint)

      try do
        Application.put_env(
          :lynx,
          LynxWeb.Endpoint,
          Keyword.put(original, :http_max_body_length, 12_345)
        )

        assert Config.max_body_length() == 12_345
      after
        Application.put_env(:lynx, LynxWeb.Endpoint, original)
      end
    end

    test "Lynx.Config.max_body_length/0 falls back to 8 MB when unset" do
      original = Application.get_env(:lynx, LynxWeb.Endpoint)

      try do
        Application.put_env(
          :lynx,
          LynxWeb.Endpoint,
          Keyword.delete(original, :http_max_body_length)
        )

        assert Config.max_body_length() == 8_000_000
      after
        Application.put_env(:lynx, LynxWeb.Endpoint, original)
      end
    end
  end
end
