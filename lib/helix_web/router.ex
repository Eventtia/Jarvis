defmodule HelixWeb.Router do
  use HelixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HelixWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelixWeb.Authenticator # This plug adds the "current_user" and "eventtia_jwt" to every request.
  end

  pipeline :browser_authenticated do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HelixWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelixWeb.Authenticator # This plug adds the "current_user" and "eventtia_jwt" to every request.
    plug HelixWeb.UserAuthenticated # This plug adds the "current_user" and "eventtia_jwt" to every request.
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelixWeb do
    pipe_through :browser

    get "/", AccountController, :login
    get "/account/login", AccountController, :login
    get "/account/logout", AccountController, :logout
    post "/account/process-login", AccountController, :process_login
    get "/show/:test", AccountController, :show
    get "/redirect", AccountController, :redirect_error
  end

  scope "/", HelixWeb do
    pipe_through :browser_authenticated

    get "/account/show", AccountController, :show
    get "/integration-logs/index", IntegrationLogsController, :index
    get "/integration-logs/show/:id", IntegrationLogsController, :show
  end

  scope "/api", HelixWeb do
    pipe_through :api

    post "/integration-logs/add", IntegrationLogsController, :add
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelixWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:helix, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelixWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
