defmodule PhoenixPostmanWeb.ApiView do
  use PhoenixPostmanWeb, :view

  def render("index.json", _assigns) do
    %{status: "OK"}
  end

  def render("key.json", %{payload: key}) do
    %{key: key}
  end
end
