defmodule PhoenixPostmanWeb.ApiController do
    use PhoenixPostmanWeb, :controller

    def index(conn, _params) do
        render conn, "index.json"
    end
end
