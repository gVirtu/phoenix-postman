defmodule PhoenixPostmanWeb.ApiController do
    use PhoenixPostmanWeb, :controller

    @doc """
    Status

    ## This is an example of description

     * Markdown is okay here
     * [And so are URLs](http://localhost:4000)

        # this is code
        def index(conn, _params) do
            render conn, "index.json"
        end
    """
    def index(conn, _params) do
        render conn, "index.json"
    end

    def index_alt(conn, _params) do
        render conn, "index.json"
    end

    def show(conn, params) do
        render conn, "key.json", payload: params["key"]
    end
end
