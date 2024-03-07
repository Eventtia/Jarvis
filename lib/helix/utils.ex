defmodule Helix.Utils do
  require Logger

    # Given a string, returns a page number.
    # Use this function only for paginators.
    # Only works for positive integers.
    def get_page(string) do
      result = 	cond do
                string == "" -> 0
                string == nil -> 0
                string == 0 -> 1
                string <= 0 -> 1
                true -> String.to_integer(string)
              end
      cond do
        result <= 0 -> 1
        true -> result
      end
    end

  end
