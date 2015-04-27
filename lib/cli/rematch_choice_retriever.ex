defmodule CLI.RematchChoiceRetriever do
  @console_interactor CLI.ConsoleInteractor

  def get_choice do
    @console_interactor.prompt_user_with_message("Would you like to play again? (y)es (n)o:")
    |> clean_and_validate_response
  end

  defp get_choice(message) do
    @console_interactor.prompt_user_with_message(message)
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
end
