defmodule Helix.TokenManager do
  @secret_token Application.get_env(:helix, :secret_token)

  def issue_token(name) do
    token = Phoenix.Token.sign(@secret_token, "user auth", name)
    #IO.puts "Issued token: #{token}"
    token
  end

  def validate_token(token) do
    token = String.replace(token, "Bearer ", "") |> String.replace(" ", "") |> String.replace("bearer", "")
    case Phoenix.Token.verify(@secret_token, "user auth", token, max_age: 864000000000) do
      {:ok, token_account } -> {:ok, token_account}
      _ -> {:error}
    end
  end
end
