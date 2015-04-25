defmodule Display do
  @game_choices %{ 1 => :hvh,
                   2 => :hvc,
                   3 => :cvh,
                   4 => :cvc }
  @board Board

  def show_welcome_message do
    IO.puts colorize("****************************\n" <>
                     "** Welcome to Tic-Tac-Toe **\n" <>
                     "****************************\n", :yellow)
  end

  def show_board(board) do
    board
    |> Enum.with_index
    |> Enum.map(fn(position) ->
      position
      |> _get_value
      |> _set_correct_color
    end)
    |> _show_board
  end

  def show_message(message), do: IO.write colorize("\n#{message}\n", :blue)

  def get_move(board),          do: ask_for_move |> _valid_move(board)
  def get_move(board, message), do: ask_for_move(message) |> _valid_move(board)

  def ask_for_move,          do: prompt_user_input_with_message("Choose a move from the board: ")
  def ask_for_move(message), do: prompt_user_input_with_message(message)

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

  defp _validate_choice({choice, _}), do: @game_choices[choice]
  defp _validate_choice(:error),      do: get_game_choice("Please choose a number from 1-4: ")

  defp _valid_move(move, board), do: move |> convert_to_number |> _validate_move(board)

  defp _validate_move({move, _}, board) do
    move = move - 1
    board
    |> @board.available_moves
    |> Enum.member?(move)
    |> within_available_moves(board, move)
  end

  defp _validate_move(:error, board),    do: get_move(board, "Please choose a valid move: ")

  defp within_available_moves(true, _, move),   do: move
  defp within_available_moves(false, board, _), do: get_move(board, "Please choose a valid move: ")

  defp convert_to_number(string), do: Integer.parse(string)

  defp prompt_user_input_with_message(message), do: IO.gets message <> "\n> "

  defp _get_value({position, index}) when position == "", do: index + 1
  defp _get_value({position, _}), do: position

  defp _set_correct_color(mark) when mark == "x", do: colorize(mark, :red)
  defp _set_correct_color(mark) when mark == "o", do: colorize(mark, :green)
  defp _set_correct_color(mark), do: mark

  defp colorize(string, color), do: Colorful.string(string, color)

  defp _show_board([a1, a2, a3,
                    b1, b2, b3,
                    c1, c2, c3]), do: IO.write "#{a1} | #{a2} | #{a3}\n" <>
                                               "---------\n"             <>
                                               "#{b1} | #{b2} | #{b3}\n" <>
                                               "---------\n"             <>
                                               "#{c1} | #{c2} | #{c3}\n"
end
