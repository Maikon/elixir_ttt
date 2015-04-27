defmodule CLI.ConsoleInteractor do

  def convert_to_number(string) do
    string |> Integer.parse
  end

  def prompt_user_with_message(message) do
    IO.gets message <> "\n> "
  end
end
