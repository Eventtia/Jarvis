defmodule HelixWeb.AccountHTML do
  use HelixWeb, :html
  embed_templates "html/accounts/*"

  def greet(assigns) do
    ~H"""
    <p>Hello, <%= @name %>!</p>
    """
  end
end
