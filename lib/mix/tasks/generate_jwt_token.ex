defmodule Mix.Tasks.Helix.GenerateJwt do
  use Mix.Task
  import Ecto.Query, warn: false
  alias Helix.TokenManager

  @shortdoc "Generates JWT Token"
  def run(name) do
    #Application.ensure_all_started(:httpoison)
    Mix.Task.run("app.start", [])
    #Ecto.Migrator.run(Helix.Repo, :up, all: true)

    case name do
      [] -> IO.puts "Please provide a token name"
      "" -> IO.puts "Please provide a token name"
      nil -> IO.puts "Please provide a token name"
      _ -> TokenManager.issue_token(name)
    end
  end
end
