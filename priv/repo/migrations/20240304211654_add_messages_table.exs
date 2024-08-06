defmodule Helix.Repo.Migrations.AddMessages do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    create table(:messages, primary_key: false) do
      add :uuid, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :attendee_uuid, :string, size: 36
      add :message_lang, :string
      add :channel, :string, default: "whatsapp"
      add :payload, :string, size: 10000
      add :server_response_details, :string, size: 1000
      add :sent_on, :naive_datetime
      timestamps()
    end
    create unique_index(:messages, [:uuid])
  end
end



#execute "ALTER TABLE users ADD COLUMN uuid UUID DEFAULT (uuid_generate_v4());"
#execute "ALTER TABLE posts ALTER COLUMN publish_at TYPE TIMESTAMP without time zone;"
