# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.EndpointTest do
  use ExUnit.Case, async: true

  describe ":http_max_body_length endpoint config" do
    test "defaults to 8 MB so existing deployments are unaffected" do
      assert Application.get_env(:lynx, LynxWeb.Endpoint)[:http_max_body_length] == 8_000_000
    end

    test "is wired into Plug.Parsers as the :length option" do
      configured = Application.get_env(:lynx, LynxWeb.Endpoint)[:http_max_body_length]
      parsers_opts = Plug.Parsers.init(parsers: [:urlencoded, :json], length: configured)

      assert parsers_opts.length == configured
    end
  end
end
