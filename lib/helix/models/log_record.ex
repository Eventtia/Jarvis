defmodule Helix.LogRecord do
	@moduledoc false
  use Ecto.Schema
  import Ecto.Changeset


  @derive { Jason.Encoder, only: [:event_id, :event_name, :date, :attendee_data, :server_response_details, :server_response_code, :aux_field] }

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "log_records" do
    field :event_id, :integer
    field :event_name, :string
    field :date, :naive_datetime
    field :attendee_data, :string
    field :server_response_details, :string
    field :server_response_code, :string
    field :aux_field, :string
    timestamps()
  end

  @doc false
  def changeset(log_record, attrs) do
    log_record
    |> cast(attrs, [:event_id, :event_name, :date, :attendee_data, :server_response_details, :server_response_code, :aux_field])
    |> validate_required([:event_id, :event_name, :attendee_data, :server_response_details, :server_response_code])
  end
end
