defmodule PhoenixPostmanWeb.Router do
  use PhoenixPostmanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Plug.PostmanDump
  end

  scope "/api", PhoenixPostmanWeb do
    pipe_through :api

    get "/", ApiController, :index
    get "/is-this-bad/ok", ApiController, :index
    get "/is-this-bad/ok", ApiController, :index_alt
    get "/data/:key/dynamic*anything", ApiController, :show
  end
end
