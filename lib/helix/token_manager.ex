defmodule Helix.TokenManager do
  @secret_token Application.get_env(:helix, :secret_token)

  def issue_token(username) do
    token = Phoenix.Token.sign(@secret_token, "user auth", username)
    IO.puts "Issued token: #{token}"
    token
  end

  def validate_token(token) do
    results = Phoenix.Token.verify(@secret_token, "user auth", token, max_age: 864000000000)
  end
end
