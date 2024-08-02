defmodule Helix.Repo.Migrations.AddMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :attende_uuid, :integer
      add :message_lang, :string
      add :channel, :string, default: "whatsapp" # Can be "whatsapp", tomorrow it can be something different.
      add :payload, :string, size: 10000
      add :server_response_details, :string, size: 1000
      add :sent_on, :naive_datetime
      timestamps()
    end
    create unique_index(:messages, [:id])
  end
end
