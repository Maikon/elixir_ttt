defmodule CLI.GameChoiceRetriever do
  @console_interactor CLI.ConsoleInteractor
  @game_choices %{ 1 => :hvh,
                   2 => :hvc,
                   3 => :cvh,
                   4 => :cvc }

  def get_game_choice, do: ask_for_game_choice |> valid_choice
  def get_game_choice(message), do: ask_for_game_choice(message) |> valid_choice

  def ask_for_game_choice do
    @console_interactor.prompt_user_with_message("Choose a game option from 1-4:\n" <>
                                   "1) Human vs Human "               <>
                                   "2) Human vs Computer "            <>
                                   "3) Computer vs Human "            <>
                                   "4) Computer vs Computer\n")
  end

  def ask_for_game_choice(message) do
    @console_interactor.prompt_user_with_message(message)
  end

  defp valid_choice(choice), do: choice |> @console_interactor.convert_to_number |> _validate_choice

  defp _validate_choice(:error) do
    get_game_choice("Please choose a number from 1-4: ")
  end

  defp _validate_choice({choice, _}) do
    choice = @game_choices[choice]
    if choice do
      choice
    else
      get_game_choice("Please choose a number from 1-4: ")
    end
  end
end
