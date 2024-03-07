defmodule HelixWeb.UserAuthenticated do
  import Plug.Conn
  use HelixWeb, :controller

  def init(opts), do: opts

  def call(conn, _opts) do
    jwt = get_session(conn, :eventtia_jwt)
    #current_user = get_session(conn, :current_user)

    case jwt do
      nil -> conn |> put_flash(:error, "You are not logged in.")
                  |> redirect(to: ~p"/account/login")
      ""  -> conn |> put_flash(:error, "You are not logged in.")
                  |> redirect(to: ~p"/account/login")
      _ ->   conn
    end

    if jwt == nil do

    else
      conn
    end

  end

end
