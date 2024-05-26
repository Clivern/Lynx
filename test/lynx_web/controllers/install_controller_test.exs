# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.InstallControllerTest do
  use LynxWeb.ConnCase

  describe "POST /action/install" do
    test "installs the app with valid params", %{conn: conn} do
      params = %{
        app_name: "Lynx",
        app_url: "https://lynx.com",
        app_email: "hello@lynx.com",
        admin_name: "John Doe",
        admin_email: "john@example.com",
        admin_password: "password123"
      }

      conn = post(conn, "/action/install", params)

      assert json_response(conn, 200) == %{
               "successMessage" => "Application installed successfully"
             }
    end

    test "returns an error for app_name", %{conn: conn} do
      params = %{
        app_name: "",
        app_url: "https://lynx.com",
        app_email: "hello@lynx.com",
        admin_name: "John Doe",
        admin_email: "john@example.com",
        admin_password: "password123"
      }

      conn = post(conn, "/action/install", params)
      assert json_response(conn, 400) == %{"errorMessage" => "Application name is invalid"}
    end

    test "returns an error for app_url", %{conn: conn} do
      params = %{
        app_name: "Lynx",
        app_url: "",
        app_email: "hello@lynx.com",
        admin_name: "John Doe",
        admin_email: "john@example.com",
        admin_password: "password123"
      }

      conn = post(conn, "/action/install", params)
      assert json_response(conn, 400) == %{"errorMessage" => "Application URL is invalid"}
    end

    test "returns an error for app_email", %{conn: conn} do
      params = %{
        app_name: "Lynx",
        app_url: "https://lynx.com",
        app_email: "",
        admin_name: "John Doe",
        admin_email: "john@example.com",
        admin_password: "password123"
      }

      conn = post(conn, "/action/install", params)
      assert json_response(conn, 400) == %{"errorMessage" => "Application email is invalid"}
    end

    test "returns an error for admin_name", %{conn: conn} do
      params = %{
        app_name: "Lynx",
        app_url: "https://lynx.com",
        app_email: "hello@lynx.com",
        admin_name: "",
        admin_email: "john@example.com",
        admin_password: "password123"
      }

      conn = post(conn, "/action/install", params)
      assert json_response(conn, 400) == %{"errorMessage" => "User name is required"}
    end

    test "returns an error for admin_email", %{conn: conn} do
      params = %{
        app_name: "Lynx",
        app_url: "https://lynx.com",
        app_email: "hello@lynx.com",
        admin_name: "John Doe",
        admin_email: "",
        admin_password: "password123"
      }

      conn = post(conn, "/action/install", params)
      assert json_response(conn, 400) == %{"errorMessage" => "User email is required"}
    end

    test "returns an error for admin_password", %{conn: conn} do
      params = %{
        app_name: "Lynx",
        app_url: "https://lynx.com",
        app_email: "hello@lynx.com",
        admin_name: "John Doe",
        admin_email: "john@example.com",
        admin_password: ""
      }

      conn = post(conn, "/action/install", params)
      assert json_response(conn, 400) == %{"errorMessage" => "User password is required"}
    end
  end
end
