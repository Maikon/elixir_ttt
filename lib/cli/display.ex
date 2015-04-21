defmodule Cli.Display do
  @game_choices %{ 1 => :hvh,
                   2 => :hvc,
                   3 => :cvh,
                   4 => :cvc }

  def show_board(board) do
    board
    |> Enum.with_index
    |> Enum.map(fn(position) ->
      position |> _get_value
    end)
    |> _show_board
  end

  def ask_for_move,          do: IO.gets "Choose a move from the board: "
  def ask_for_move(message), do: IO.gets message

  def get_move,          do: ask_for_move |> Integer.parse |> _validate_move
  def get_move(message), do: ask_for_move(message) |> Integer.parse |> _validate_move


  def get_game_choice, do: ask_for_game_choice |> Integer.parse |>  _validate_choice
  def get_game_choice(message), do: ask_for_game_choice(message) |> Integer.parse |>  _validate_choice

  def ask_for_game_choice, do: IO.gets "Choose a game option from 1-4:\n" <>
                                       "1) Human vs Human "               <>
                                       "2) Human vs Computer "            <>
                                       "3) Computer vs Human "            <>
                                       "4) Computer vs Computer\n"
  def ask_for_game_choice(message), do: IO.gets message

  defp _validate_choice({choice, _}), do: @game_choices[choice]
  defp _validate_choice(:error),      do: get_game_choice("Please choose a number from 1-4: ")

  defp _validate_move({move, _}), do: move - 1
  defp _validate_move(:error),    do: get_move("Please choose a valid move: ")

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
