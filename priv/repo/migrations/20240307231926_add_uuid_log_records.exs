defmodule Helix.Repo.Migrations.AddUuidLogRecords do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
    execute "ALTER TABLE log_records DROP COLUMN id;"
    execute "ALTER TABLE log_records ADD COLUMN id UUID DEFAULT (uuid_generate_v4());"
    execute "ALTER TABLE log_records ADD PRIMARY KEY (id);"
  end
end
