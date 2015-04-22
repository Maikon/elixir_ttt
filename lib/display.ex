defmodule Display do
  @game_choices %{ 1 => :hvh,
                   2 => :hvc,
                   3 => :cvh,
                   4 => :cvc }

  def show_welcome_message do
    IO.puts "****************************\n" <>
            "** Welcome to Tic-Tac-Toe **\n" <>
            "****************************\n"
  end

  def show_board(board) do
    board
    |> Enum.with_index
    |> Enum.map(fn(position) ->
      position |> _get_value
    end)
    |> _show_board
  end

  def show_message(message), do: IO.write "\n#{message}\n"

  def get_move,          do: ask_for_move |> _valid_move
  def get_move(message), do: ask_for_move(message) |> _valid_move

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

  defp valid_choice(choice), do: choice |> convert_to_number |> _validate_choice

  defp _validate_choice({choice, _}), do: @game_choices[choice]
  defp _validate_choice(:error),      do: get_game_choice("Please choose a number from 1-4: ")

  defp _valid_move(move), do: move |> convert_to_number |> _validate_move

  defp _validate_move({move, _}), do: move - 1
  defp _validate_move(:error),    do: get_move("Please choose a valid move: ")

  defp convert_to_number(string), do: Integer.parse(string)

  defp prompt_user_input_with_message(message), do: IO.gets message

  defp _get_value({position, index}) when position == "", do: index + 1
  defp _get_value({position, _}), do: position

  defp _show_board([a1, a2, a3,
                    b1, b2, b3,
                    c1, c2, c3]), do: IO.write "#{a1} | #{a2} | #{a3}\n" <>
                                               "---------\n"             <>
                                               "#{b1} | #{b2} | #{b3}\n" <>
                                               "---------\n"             <>
                                               "#{c1} | #{c2} | #{c3}\n"
end
