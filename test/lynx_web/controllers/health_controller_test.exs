# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.HealthControllerTest do
  use LynxWeb.ConnCase

  test "GET /_health", %{conn: conn} do
    conn = get(conn, "/_health")
    assert json_response(conn, 200) == %{"status" => "ok"}
  end
end
