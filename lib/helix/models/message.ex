defmodule Helix.Message do
	@moduledoc false
  use Ecto.Schema
  import Ecto.Changeset


  @derive { Jason.Encoder, only: [:uuid, :attendee_uuid, :message_lang, :channel, :payload, :server_response_details, :sent_on, :phone_number, :status, :message_type] }

  @primary_key {:uuid, Ecto.UUID, autogenerate: true}
  schema "messages" do
    field :attendee_uuid, :string
    field :message_lang, :string # Can be "en", "es", "pt", etc.
    field :message_type, :string # Can be "successful_registration", "rejected_registration", "deleted_registration", etc.
    field :channel, :string # Can be "whatsapp", tomorrow it can be something different.
    field :payload, :string # Contains payload in json format related to the attendee and event.
    field :server_response_details, :string # Contains server response details in json format.
    field :sent_on, :naive_datetime # Date the message was sent
    field :phone_number, :string # Phone number of the attendee
    field :status, :string # Status of the message
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:attendee_uuid, :message_lang, :channel, :payload, :message_type, :phone_number, :status])
    |> validate_required([:attendee_uuid, :phone_number, :message_type])
  end
end
