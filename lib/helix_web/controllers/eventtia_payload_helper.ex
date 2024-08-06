defmodule Helix.EventtiaPayloadHelper do
  @moduledoc false

	def extract_data(payload) do
    # Attendee Data
	  uuid = _extract_basic_attendee_field(payload, "uuid")
		qr_code = _extract_basic_attendee_field(payload, "qr_code")
    first_name = _extract_attendee_field(payload, "first_name")
    last_name = _extract_attendee_field(payload, "last_name")
    phone_number = _extract_attendee_field(payload, "telephone")


    # Event Data
    event_data = _extract_event_data(payload)

    %{ attendee: %{ uuid: uuid,
                    full_name: "#{first_name} #{last_name}",
                    phone_number: phone_number,
                    qr_code: qr_code},
      event: event_data }
	end


  defp _extract_event_data(body) do
    event_data = Enum.find_value(body["included"], fn(item) ->  case item do
                                                                  %{ "id" => event_id, "type" => "events" } -> item
                                                                  _ -> false
                                                                end
                                    end)

    name = event_data["attributes"]["name"]
    start_date = event_data["attributes"]["start_date"]
    end_date = event_data["attributes"]["end_date"]
    logo_small = event_data["attributes"]["logo"]["small"]
    logo_large = event_data["attributes"]["logo"]["large"]

    %{name: name, start_date: start_date, end_date: end_date, logo_small: logo_small, logo_large: logo_large}

  end

	# Function that extracts "hard coded" fields.
	defp _extract_basic_attendee_field(body, field) do
    body["data"]["attributes"][field]
  end

	# Function that extracts custom fields.
	defp _extract_attendee_field(body, field_name) do
    field_id = _get_attendee_field_id(body, field_name)
    body["data"]["attributes"]["fields"][field_id]
  end

	defp _get_attendee_field_id(body, field_name) do
    Enum.find_value(body["included"], fn(item) ->  case item do
                                                    %{  "id" => field_id,
                                                        "type" => "attendee_type_custom_fields",
                                                        "attributes" => %{ "name" => ^field_name, "input_type" => 1}} -> field_id
                                                    _ -> false
                                                  end
                                    end)
	end

end
