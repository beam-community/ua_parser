defmodule Example.Router do
  use Example.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Example do
    pipe_through :browser # Use the default browser stack
    get "/user_agent", FooController, :user_agent

    get "/", PageController, :index
  end
end
