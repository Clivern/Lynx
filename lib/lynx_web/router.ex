# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.Router do
  use LynxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LynxWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :add_server_header
    plug Lynx.Middleware.Logger
    plug Lynx.Middleware.UIAuthMiddleware
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :add_server_header
    plug Lynx.Middleware.Logger
    plug Lynx.Middleware.APIAuthMiddleware
  end

  pipeline :pub do
    plug :accepts, ["json"]
    plug :add_server_header
    plug Lynx.Middleware.Logger
  end

  pipeline :client do
    plug :accepts, ["json"]
    plug :add_server_header
    plug Lynx.Middleware.Logger
  end

  scope "/", LynxWeb do
    pipe_through :browser

    get "/404", PageController, :not_found
    get "/install", PageController, :install
    get "/", PageController, :home
    get "/login", PageController, :login
    get "/logout", PageController, :logout
    get "/admin/profile", PageController, :profile
    get "/admin/snapshots", PageController, :snapshots
    get "/admin/teams", PageController, :teams
    get "/admin/users", PageController, :users
    get "/admin/projects", PageController, :projects
    get "/admin/projects/:uuid", PageController, :project
    get "/admin/settings", PageController, :settings
    get "/admin/state/download/:uuid", PageController, :state
    get "/admin/environment/download/:uuid", PageController, :environment
  end

  scope "/", LynxWeb do
    pipe_through :pub

    get "/_health", HealthController, :health
    get "/_ready", ReadyController, :ready
    post "/action/install", MiscController, :install
    post "/action/auth", MiscController, :auth
  end

  scope "/api/v1", LynxWeb do
    pipe_through :api

    # User Endpoints
    get "/user", UserController, :list
    post "/user", UserController, :create
    get "/user/:uuid", UserController, :index
    put "/user/:uuid", UserController, :update
    delete "/user/:uuid", UserController, :delete

    # Team Endpoints
    get "/team", TeamController, :list
    post "/team", TeamController, :create
    get "/team/:uuid", TeamController, :index
    put "/team/:uuid", TeamController, :update
    delete "/team/:uuid", TeamController, :delete

    # Settings Endpoints
    put "/action/update_settings", SettingsController, :update

    # Profile Endpoints
    post "/action/update_profile", ProfileController, :update

    # Fetch API Key Endpoint
    get "/action/fetch_api_key", ProfileController, :fetch_api_key

    # Rotate API Key Endpoint
    post "/action/rotate_api_key", ProfileController, :rotate_api_key

    # Task Endpoints
    get "/task/:uuid", TaskController, :index

    # Project Endpoints
    get "/project", ProjectController, :list
    post "/project", ProjectController, :create
    get "/project/:uuid", ProjectController, :index
    put "/project/:uuid", ProjectController, :update
    delete "/project/:uuid", ProjectController, :delete

    # Snapshot Endpoints
    get "/snapshot", SnapshotController, :list
    post "/snapshot", SnapshotController, :create
    get "/snapshot/:uuid", SnapshotController, :index
    put "/snapshot/:uuid", SnapshotController, :update
    delete "/snapshot/:uuid", SnapshotController, :delete
    post "/snapshot/restore/:uuid", SnapshotController, :restore

    # Environment Endpoints
    get "/project/:p_uuid/environment", EnvironmentController, :list
    post "/project/:p_uuid/environment", EnvironmentController, :create
    get "/project/:p_uuid/environment/:e_uuid", EnvironmentController, :index
    put "/project/:p_uuid/environment/:e_uuid", EnvironmentController, :update
    delete "/project/:p_uuid/environment/:e_uuid", EnvironmentController, :delete
  end

  scope "/client", LynxWeb do
    pipe_through :client

    # Locking API Endpoints
    post "/:t_slug/:p_slug/:e_slug/lock", LockController, :lock
    post "/:t_slug/:p_slug/:e_slug/unlock", LockController, :unlock

    # State API Endpoints
    get "/:t_slug/:p_slug/:e_slug/state", StateController, :index
    post "/:t_slug/:p_slug/:e_slug/state", StateController, :create
  end

  defp add_server_header(conn, _opts) do
    conn
    |> put_resp_header("x-server-version", "lynx/0.12.0")
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LynxWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
