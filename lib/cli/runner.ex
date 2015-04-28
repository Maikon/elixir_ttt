defmodule CLI.Runner do
  @game_status_message 1

  def start(%{game: game, display: display}) do
    try do
      game.play(%{board: get_board, display: display})
      |> get_result_message
      |> show_message(display)
      display
      |> user_wants_rematch
      |> another_round(%{game: game, display: display})
    rescue
      ErlangError -> show_farewell_message(display)
    end
  end

  def another_round(:yes, setup),              do: start(setup)
  def another_round(:no, %{display: display}), do: show_farewell_message(display)

  defp get_board,                      do: Board.new
  defp get_result_message(game),       do: elem(game, @game_status_message)
  defp show_message(message, display), do: display.show_message(message)
  defp user_wants_rematch(display),    do: display.get_rematch_choice
  defp show_farewell_message(display), do: display.show_message("Thanks for playing!")
end
