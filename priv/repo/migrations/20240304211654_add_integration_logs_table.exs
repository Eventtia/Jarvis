defmodule Helix.Repo.Migrations.AddIntegrationLogsTable do
  use Ecto.Migration

  def change do
    create table(:log_records) do
      add :event_id, :integer
      add :event_name, :string
      add :date, :naive_datetime
      add :attendee_data, :string, size: 1000
      add :server_response_details, :string, size: 1000
      add :server_response_code, :string
      add :aux_field, :string
      timestamps()
    end
    create unique_index(:log_records, [:id])
  end
end
