defmodule PhoenixPostmanWeb.ApiControllerTest do
  use PhoenixPostmanWeb.ConnCase

  test "GET /api", %{conn: conn} do
    path = api_path(conn, :index)
    conn = get(conn, path)

    assert json_response(conn, 200) == %{"status" => "OK"}
  end
end
