defmodule Helix.Repo.Migrations.AddUserPhoneNumberToMessages do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE messages ADD COLUMN phone_number varchar(30);"
    execute "ALTER TABLE messages ADD COLUMN message_type varchar(30);"
    execute "ALTER TABLE messages ADD COLUMN status varchar(10);"
  end
end
