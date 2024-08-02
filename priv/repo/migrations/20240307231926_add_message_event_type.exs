defmodule Helix.Repo.Migrations.AddUuidLogRecords do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE messages ADD COLUMN event_type varchar(100);"
  end
end
