defmodule HelixWeb.IntegrationLogsHTML do
  use HelixWeb, :html
  embed_templates "html/integration_logs/*"

  def greet(assigns) do
    ~H"""
    <p>Hello, <%= @name %>!</p>
    """
  end
end
