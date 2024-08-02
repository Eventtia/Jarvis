defmodule HelixWeb.MainController do
  #alias Helix.TokenManager
  use HelixWeb, :controller
  use Phoenix.Component

  def status(conn, _params) do
    conn |> put_status(200) |> json(%{status: "success", data: "OK"})
  end

end
