defmodule PhoenixPostmanWeb.Router do
  use PhoenixPostmanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixPostmanWeb do
    pipe_through :api

    get "/", ApiController, :index
  end
end
