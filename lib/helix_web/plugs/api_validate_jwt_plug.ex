defmodule HelixWeb.ValidateJWTPlug do
  alias Helix.TokenManager
  import Plug.Conn
  use HelixWeb, :controller

  def init(opts), do: opts

  def call(conn, _opts) do
    authorization_token = Enum.at(get_req_header(conn, "authorization"), 0)
    case TokenManager.validate_token(authorization_token) do
      {:ok, token_name } -> assign(conn, :token_name, token_name)
      _ -> conn |> put_status(403) |> json(%{status: "fail", data: "Invalid JWT Token"}) |> halt()
    end
  end

end
