# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.TaskControllerTest do
  use LynxWeb.ConnCase

  setup %{conn: conn} do
    params = %{
      app_name: "Lynx",
      app_url: "https://lynx.com",
      app_email: "hello@lynx.com",
      admin_name: "John Doe",
      admin_email: "john@example.com",
      admin_password: "password123"
    }

    conn = post(conn, "/action/install", params)
    {:ok, conn: conn}
  end
end
