defmodule HelixWeb.IntegrationLogsController do
  alias Helix.LogRecordsContext
  alias Helix.TokenManager
  use HelixWeb, :controller
  use Phoenix.Component

  def index(conn, params) do
    page = params["page"]

    #source = params["source"]
		data = LogRecordsContext.index(page)
    #%{ log_records: log_records, count: log_records_count, pages: pages }
    #fields = %{"email" => "esteban@eventtia.com", "password" => "N0s3M3V4aolv1d4r!!!!"}
    render(conn, :index, data: data)
  end

  def show(conn, params) do
    id = params["id"]

		log_details = LogRecordsContext.get(id)
    # IO.inspect data
    #%{ log_records: log_records, count: log_records_count, pages: pages }
    #fields = %{"email" => "esteban@eventtia.com", "password" => "N0s3M3V4aolv1d4r!!!!"}
    render(conn, :show, log_details: log_details)
  end

  def add(conn, params) do
    # token = TokenManager.issue_token("eventtia-cartier")
    # TokenManager.validate_token(token)
    case validate_security_token(conn) do
      false -> conn |> put_status(403) |> json(%{status: "fail", data: "Invalid Token"})
      true -> case LogRecordsContext.create(params) do
                {:ok, log_record} -> conn |> put_status(201) |> json(%{status: "success", data: log_record})
                {:error, changeset} -> conn |> put_status(400) |> json(%{status: "fail", data: changeset})
              end
              #json(conn, %{status: "success", data: nil})
    end

  end

  defp validate_security_token(conn) do
    token = Enum.at(get_req_header(conn, "authorization"), 0)
    case TokenManager.validate_token(token) do
      {:ok, username } -> case username do
                            "eventtia-cartier" -> true
                            _ -> false
                          end
      {:error, _} -> false
    end
  end

end
