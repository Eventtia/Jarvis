defmodule Helix.LogRecordsContext do
	@moduledoc false
	import Ecto.Query, warn: false
	alias Helix.Repo
  alias Helix.Utils
	alias Helix.LogRecord
  import HelixWeb.ErrorHelper

  def get(id) do
    query = from lr in LogRecord,
						where: 	lr.id == ^id,
						limit: 1

		Repo.one(query)
  end

  def create(params) do
    event_id = params["event_id"]
    event_name = params["event_name"]
    date = params["date"]
    attendee_data = String.slice(params["attendee_data"], 0..990)
    server_response_details = String.slice(params["server_response_details"], 0..990)
    server_response_code = params["server_response_code"]
    aux_field = String.slice(params["aux_field"], 0..998)

    mapped_parameters = %{event_id: event_id, event_name: event_name, date: date, attendee_data: attendee_data, server_response_details: server_response_details, server_response_code: server_response_code, aux_field: aux_field}
    changeset = LogRecord.changeset(%LogRecord{}, mapped_parameters)
    case Repo.insert(changeset) do
      {:ok, log_record} -> {:ok, log_record}
      {:error, changeset} -> {:error, Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
    end


    # UserBookmark.changeset(%UserBookmark{}, %{	user_id: user_id,
    #                                             item_id: report_id,
    #                                             item_type: "report"
    #                                           })
    # case Repo.insert(changeset) do
    #   {:error, changeset} -> {:error, Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
    #   {:ok, changeset} -> {:ok}
    # end
  end

	def index(page) do
		page = Utils.get_page(page)
		rows_per_page = 10

		offset = (page - 1) * rows_per_page

		query = from lr in LogRecord


		# query = cond do
		# 					source == nil or source == "" -> 	query
		# 					source != "" -> from [t] in query,
		# 													where: t.source == ^source
		# end

		# Count the number of log records.
		count_query = from [lr] in query, select: count(lr.id)
		log_records_count = List.first(Repo.all(count_query))
		pages = ceil(log_records_count / rows_per_page)

		# Get's the database records
		query = from [lr] in query,
						select: %{ id: lr.id, event_id: lr.event_id, event_name: lr.event_name, date: lr.date, server_response_code: lr.server_response_code, inserted_at: lr.inserted_at},
						limit: ^rows_per_page, offset: ^offset,
						order_by: [desc: lr.inserted_at]

		log_records = Repo.all(query)

		case log_records do
			nil -> nil
			_ ->	%{ log_records: log_records, count: log_records_count, pages: pages, page: page }
		end

	end

end
