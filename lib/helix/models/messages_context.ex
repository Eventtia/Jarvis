defmodule Helix.MessagesContext do
  @moduledoc false
	import Ecto.Query, warn: false
	import HelixWeb.ErrorHelper
	alias Helix.Repo
	alias Helix.Message
	alias Helix.EventtiaPayloadHelper
	alias Helix.WhatsappHelper

	def send_message(payload) do
    #1. Extract and clean data
    data = EventtiaPayloadHelper.extract_data(payload)
    uuid = data.attendee.uuid
    phone_number = data.attendee.phone_number
    full_name = data.attendee.full_name
    event_name = data.event.name
    start_date = data.event.start_date
    qr_code = data.attendee.qr_code

    IO.puts ">>UUID: #{uuid}"
    IO.puts ">>Telephone: #{phone_number} || QR Code: #{qr_code}"
    IO.puts ">>Full Name: #{full_name}"

    #2. Store message in database
    case create_message(uuid, phone_number, data, "new_attendee") do
      {:ok, message} -> IO.puts ">>Message created"
                        #2.1. Send message
                        WhatsappHelper.send_test_message(phone_number, full_name, event_name, start_date)
                        #2.2. Update status in database
      {:error, error} -> IO.puts ">>Error creating message: #{error}"
    end

	end

	def create_message(attendee_uuid, phone_number, payload, message_type) do
		message_lang = "en"
    channel = "whatsapp"
		changeset = Message.changeset(%Message{}, %{	attendee_uuid: attendee_uuid,
		                                              phone_number: phone_number,
																						      message_lang: message_lang,
																									channel: channel,
																									payload: Poison.encode!(payload),
																									message_type: message_type,
																									status: "new"
																								})
		case Repo.insert(changeset) do
			{:error, changeset} -> {:error, Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
			{:ok, changeset} -> {:ok, changeset}
		end
	end

end
