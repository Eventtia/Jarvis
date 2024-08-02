defmodule HelixWeb.MessagesController do
  alias Helix.TokenManager
  use HelixWeb, :controller
  use Phoenix.Component

  def add(conn, _params) do
    validate_security_token(conn)
    conn |> put_status(200) |> json(%{status: "success", data: "OK"})
  end

  defp validate_security_token(conn) do
    token = Enum.at(get_req_header(conn, "authorization"), 0)
    case TokenManager.validate_token(token) do
      {:ok, username } -> case username do
                            "eventtia-cartier" -> true
                            _ -> false
                          end
      {:error, _} -> false
    end
  end

end
