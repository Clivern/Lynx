# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule BanditWeb.Router do
  use BanditWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BanditWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Bandit.Middleware.Logger
    plug Bandit.Middleware.UIAuthMiddleware
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Bandit.Middleware.Logger
    plug Bandit.Middleware.APIAuthMiddleware
  end

  pipeline :pub do
    plug :accepts, ["json"]
    plug Bandit.Middleware.Logger
  end

  pipeline :client do
    plug :accepts, ["json"]
    plug Bandit.Middleware.Logger
  end

  scope "/", BanditWeb do
    pipe_through :browser

    get "/install", PageController, :install
    get "/", PageController, :home
    get "/login", PageController, :login
    get "/logout", PageController, :logout
    get "/admin/projects", PageController, :projects
    get "/admin/projects/:id", PageController, :project
    get "/admin/projects/new", PageController, :new_project
  end

  scope "/", BanditWeb do
    pipe_through :pub

    get "/_health", HealthController, :health
    get "/_ready", ReadyController, :ready
    post "/action/install", MiscController, :install
    post "/action/auth", MiscController, :auth
  end

  scope "/api/v1", BanditWeb do
    pipe_through :api

    # User CRUD
    get "/user", UserController, :list
    post "/user", UserController, :create
    get "/user/:uuid", UserController, :index
    put "/user/:uuid", UserController, :update
    delete "/user/:uuid", UserController, :delete

    # Team CRUD
    get "/team", TeamController, :list
    post "/team", TeamController, :create
    get "/team/:uuid", TeamController, :index
    put "/team/:uuid", TeamController, :update
    delete "/team/:uuid", TeamController, :delete

    # Settings Endpoint
    put "/settings", SettingsController, :update

    # Project CRUD
    get "/project", ProjectController, :list
    post "/project", ProjectController, :create
    get "/project/:uuid", ProjectController, :index
    put "/project/:uuid", ProjectController, :update
    delete "/project/:uuid", ProjectController, :delete

    # Environment CRUD
    get "/project/:p_uuid/environment", EnvironmentController, :list
    post "/project/:p_uuid/environment", EnvironmentController, :create
    get "/project/:p_uuid/environment/:e_uuid", EnvironmentController, :index
    put "/project/:p_uuid/environment/:e_uuid", EnvironmentController, :update
    delete "/project/:p_uuid/environment/:e_uuid", EnvironmentController, :delete
  end

  scope "/client", BanditWeb do
    pipe_through :client

    # Locking API
    post "/:t_slug/:p_slug/:e_slug/lock", LockController, :lock
    post "/:t_slug/:p_slug/:e_slug/unlock", LockController, :unlock

    # State API
    get "/:t_slug/:p_slug/:e_slug/state", StateController, :index
    post "/:t_slug/:p_slug/:e_slug/state", StateController, :create
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

      live_dashboard "/dashboard", metrics: BanditWeb.Telemetry
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
