defmodule Display do
  @game_choices %{ 1 => :hvh,
                   2 => :hvc,
                   3 => :cvh,
                   4 => :cvc }
  @board Board
  @board_presenter CLI.BoardPresenter
  @move_retriever CLI.MoveRetriever
  @colorizer CLI.Colorizer

  def show_welcome_message do
    IO.puts @colorizer.colorize("****************************\n" <>
                                "** Welcome to Tic-Tac-Toe **\n" <>
                                "****************************\n", :yellow)
  end

  def show_board(board) do
    @board_presenter.show(board)
  end

  def show_message(message), do: IO.write @colorizer.colorize("\n#{message}\n", :blue)

  def get_move(board) do
    board |> @move_retriever.get_move
  end

  def get_game_choice, do: ask_for_game_choice |> valid_choice
  def get_game_choice(message), do: ask_for_game_choice(message) |> valid_choice

  def ask_for_game_choice do
    prompt_user_input_with_message("Choose a game option from 1-4:\n" <>
                                   "1) Human vs Human "               <>
                                   "2) Human vs Computer "            <>
                                   "3) Computer vs Human "            <>
                                   "4) Computer vs Computer\n")
  end
  def ask_for_game_choice(message), do: prompt_user_input_with_message(message)

  def get_input_for_rematch do
    rematch_message
    |> prompt_user_input_with_message
    |> clean_and_validate_response
  end

  def rematch_message, do: "Would you like to play again? (y)es (n)o:"

  def clear_screen do
    IO.ANSI.clear |> IO.write
    IO.ANSI.home  |> IO.write
  end

  defp get_input_for_rematch(message) do
    prompt_user_input_with_message(message)
    |> clean_and_validate_response
  end


  defp clean_and_validate_response(response) do
    response
    |> remove_whitespace
    |> validate_response
  end

  defp remove_whitespace(string), do: String.strip(string)
  defp validate_response(response) do
    case response do
      "yes" -> :yes
      "y"   -> :yes
      "no"  -> :no
      "n"   -> :no
      _     -> get_input_for_rematch("Please choose either (y)es or (n)o:")
    end
  end

  defp valid_choice(choice), do: choice |> convert_to_number |> _validate_choice

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

  defp convert_to_number(string), do: Integer.parse(string)

  defp prompt_user_input_with_message(message), do: IO.gets message <> "\n> "
end
