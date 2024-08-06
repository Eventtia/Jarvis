defmodule HelixWeb.MessagesController do
  alias Helix.WhatsappHelper
  alias Helix.MessagesContext
  alias Helix.TokenManager
  use HelixWeb, :controller
  use Phoenix.Component

  def add(conn, _params) do
    conn |> put_status(200) |> json(%{status: "success", data: "OK"})
  end

  def send_test_message(conn, params) do
    #WhatsappHelper.send_test_message(params["phone_number"])
    {:ok, body, _ } = read_body(conn)
    body = Poison.decode!(body)
    MessagesContext.send_message(body)

    conn |> put_status(200) |> json(%{status: "success", data: "OK"})
  end

end
