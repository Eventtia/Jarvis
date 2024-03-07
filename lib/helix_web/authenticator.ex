defmodule HelixWeb.Authenticator do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    jwt = get_session(conn, :eventtia_jwt)
    current_user = get_session(conn, :current_user)
    assign(conn, :eventtia_jwt, jwt)
    assign(conn, :current_user, current_user)
  end

end
