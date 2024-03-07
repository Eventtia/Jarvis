defmodule HelixWeb.AccountController do
  alias Helix.EventtiaAPI
  use HelixWeb, :controller
  use Phoenix.Component

  def login(conn, _params) do
    #render(conn, :login)
    fields = %{"email" => "", "password" => ""}
    render(conn, :login, form: to_form(fields))
  end

  def logout(conn, _params) do

    conn  |> clear_session()
          |> configure_session(drop: true)
          |> put_flash(:info, "Logged out succesfully.")
          |> redirect(to: ~p"/account/login")
  end

  def process_login(conn, params) do
    email = params["email"]
    password = params["password"]
    IO.puts("Email: #{email}, Password: #{password}")
    case EventtiaAPI.login(email, password) do
      {:ok, auth_token, username} ->  #token = SessionManager.issue_token(username, auth_token) #Phoenix.Token.sign(LogCentinelWeb.Endpoint, "user auth", auth_token)
                                      conn |> put_session(:current_user, username) |> put_session(:eventtia_jwt, auth_token) |> put_flash(:info, "Welcome #{username}") |> redirect(to: ~p"/integration-logs/index")
                  {:error, error} -> conn |> put_flash(:error, error) |> redirect(to: ~p"/account/login")
    end
    #conn |> put_flash(:info, "You are logged in.") |> redirect(to: ~p"/login")
  end

  def show(conn, params) do
    IO.inspect(params)
    name = params["test"]
    #conn = put_flash(conn, :info, "Let's pretend we have an error.") # :info and :error
    render(conn, :show, test: name)#, layout: false)
  end

  # @spec redirect_error(Plug.Conn.t(), any()) :: Plug.Conn.t()
  # def redirect_error(conn, _params) do
  #   conn
  #   |> put_flash(:error, "Let's pretend we have an error and then redirect.")
  #   |> redirect(to: ~p"/account/login")
  # end
end
