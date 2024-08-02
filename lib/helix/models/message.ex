defmodule Helix.Message do
	@moduledoc false
  use Ecto.Schema
  import Ecto.Changeset


  @derive { Jason.Encoder, only: [:uuid, :attendee_uuid, :message_lang, :channel, :payload, :server_response_details, :sent_on] }

  @primary_key {:uuid, Ecto.UUID, autogenerate: true}
  schema "messages" do
    field :attendee_uuid, :string
    field :message_lang, :string # Can be "en", "es", "pt", etc.
    field :event_type, :string # Can be "successful_registration", "rejected_registration", "deleted_registration", etc.
    field :channel, :string # Can be "whatsapp", tomorrow it can be something different.
    field :payload, :string # Contains payload in json format related to the attendee and event.
    field :server_response_details, :string # Contains server response details in json format.
    field :sent_on, :naive_datetime # Date the message was sent
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:attendee_uuid, :message_lang, :channel, :payload])
    |> validate_required([:attendee_uuid, :message_lang, :channel, :payload])
  end
end
