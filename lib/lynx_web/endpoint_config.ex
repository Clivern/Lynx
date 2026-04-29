# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.EndpointConfig do
  @moduledoc false

  @default_max_body_length 8_000_000

  def max_body_length do
    case System.get_env("APP_HTTP_MAX_BODY_LENGTH") do
      nil -> @default_max_body_length
      "" -> @default_max_body_length
      value -> String.to_integer(value)
    end
  end
end
