defmodule PhoenixPostmanWeb.ApiView do
  use PhoenixPostmanWeb, :view

  def render("index.json", _assigns) do
    %{status: "OK"}
  end
end
