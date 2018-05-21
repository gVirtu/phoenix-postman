defmodule PhoenixPostmanWeb.ApiControllerTest do
  use PhoenixPostmanWeb.ConnCase

  describe "Situation" do
    test "GET /api [Successful request]", %{conn: conn} do
      path = api_path(conn, :index)
      conn = get(conn, path)

      assert json_response(conn, 200) == %{"status" => "OK"}
    end

    require IEx
    test "GET /api/data/:key [Successful request]", %{conn: conn} do
      key = "abcde"
      path = api_path(conn, :show, key, ["dynamic", "test"])
      conn = get(conn, path)

      IEx.pry()

      assert json_response(conn, 200) == %{"key" => key}
    end
  end
end
