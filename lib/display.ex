defmodule Display do
  @game_choices %{ 1 => :hvh,
                   2 => :hvc,
                   3 => :cvh,
                   4 => :cvc }
  @board Board
  @board_presenter CLI.BoardPresenter
  @move_retriever CLI.MoveRetriever
  @game_choice_retriever CLI.GameChoiceRetriever
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

  def get_game_choice do
    @game_choice_retriever.get_game_choice
  end

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

  defp convert_to_number(string), do: Integer.parse(string)

  defp prompt_user_input_with_message(message), do: IO.gets message <> "\n> "
end
