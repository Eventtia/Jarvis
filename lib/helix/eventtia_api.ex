defmodule Helix.EventtiaAPI do

  def login(email, password) do
    url = "https://connect.eventtia.com/api/v3/auth"

    headers = ["Content-Type": "application/json"]
    body = '{"email":"#{email}", "password":"#{[password]}"}'
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]

    case HTTPoison.post(url, body, headers, options) do
       {:ok, response} ->  case response.status_code do
                            200 ->  response = JSON.decode(response.body) |> elem(1)
                                    auth_token = response["auth_token"]
                                    username = response["username"]
                                    {:ok, auth_token, username}
                            _ ->  {:error, "Invalid Username and Password"}
                           end
                      _ ->  IO.puts "(ERROR) Failed to connect to Eventtia API. Please try again later."
                            {:error, "Failed to connect to Eventtia API. Please try again later."}
    end
  end

end
