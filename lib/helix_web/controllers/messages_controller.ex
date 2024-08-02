defmodule HelixWeb.MessagesController do
  alias Helix.TokenManager
  use HelixWeb, :controller
  use Phoenix.Component

  def add(conn, _params) do
    validate_security_token(conn)
    conn |> put_status(200) |> json(%{status: "success", data: "OK"})
  end

end
