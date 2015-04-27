defmodule CLI.RematchChoiceRetriever do

  def get_choice do
    rematch_message
    |> prompt_user_input_with_message
    |> clean_and_validate_response
  end

  defp rematch_message do
    "Would you like to play again? (y)es (n)o:"
  end

  defp get_choice(message) do
    prompt_user_input_with_message(message)
    |> clean_and_validate_response
  end

  defp clean_and_validate_response(response) do
    response
    |> remove_whitespace
    |> validate_response
  end

  defp remove_whitespace(string) do
    String.strip(string)
  end

  defp validate_response(response) do
    case response do
      "yes" -> :yes
      "y"   -> :yes
      "no"  -> :no
      "n"   -> :no
      _     -> get_choice("Please choose either (y)es or (n)o:")
    end
  end

  defp prompt_user_input_with_message(message), do: IO.gets message <> "\n> "
end
