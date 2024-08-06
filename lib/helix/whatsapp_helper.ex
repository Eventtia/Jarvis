defmodule Helix.WhatsappHelper do
  @whatsapp_token Application.get_env(:helix, :whatsapp_token)
  @whatsapp_url :"https://graph.facebook.com/v20.0/347154798489139/messages"

  def send_test_message(phone_number, attendee_name, event_name, start_date) do
    headers = ["Content-Type": "application/json", "Authorization": "Bearer #{@whatsapp_token}"]

    body =  %{  messaging_product: "whatsapp",
                to: "#{phone_number}",
                type: "template",
                template: %{  name: "attendee_successful_event_registration",
                              language: %{ code: "en" },
                              components: [ %{  type: "body",
                                                parameters: [ %{ type: "text", text: "#{attendee_name}" },
                                                              %{ type: "text", text: "#{event_name}" },
                                                              %{ type: "text", text: "#{start_date}" }
                                                            ]
                                              },
                                              %{  type: "header",
                                                  parameters: [ %{  type: "document",
                                                                    document: %{ link: "https://eventtia-event-qrs.s3.amazonaws.com/event/2d2633f2f6a184c9733f83e50dedbc7d/qrs/Sample-ticket.pdf" }
                                                                  }
                                                              ]
                                              }
                                          ]
                            }
              }

    # body =  %{  messaging_product: "whatsapp",
    #             to: "#{phone_number}",
    #             type: "template",
    #             template: %{ name: "hello_world", language: %{ code: "en_US" } }
    #           }

    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 5_000]

    case HTTPoison.post(@whatsapp_url, Poison.encode!(body), headers, options) do
       {:ok, response} ->  case response.status_code do
                            200 ->    IO.puts "Message Sent"
                                      IO.inspect response
                            #          response = JSON.decode(response.body) |> elem(1)
                            #         auth_token = response["auth_token"]
                            #         username = response["username"]
                            #         {:ok, auth_token, username}
                            _ ->  IO.inspect response
                                  IO.puts "ERROR when sending"
                           end
                      _ ->  IO.puts "(ERROR) Failed to connect to WhatsApp API. Please try again later."
                            {:error, "(ERROR) Failed to connect to WhatsApp API. Please try again later."}
    end
  end


end
