defmodule Game do
  @board Board

  def play(%{board: board, display: display}) do
    display.clear_screen
    display.show_welcome_message
    display.get_game_choice
    |> players
    |> _play_game(board, display)
  end

  defp _play_game(players, board, display) do
    display.clear_screen
    display.show_board(board)
    setup = %{board: board, players: players, display: display}
    _play_game(@board.status(board), setup)
  end

  defp _play_game(:over, %{board: board}), do: board |> final_status
  defp _play_game(:ongoing, setup), do: next_player_makes_move(setup)

  defp final_status(board) do
    if @board.winner(board) do
      {board, @board.last_move_mark(board) <> " won!"}
    else
      {board, "It's a draw!"}
    end
  end

  defp next_player_makes_move(%{board: board, players: players, display: display}) do
    new_board = players
                |> get_first_player
                |> get_move_from_player(%{display: display, board: board})
                |> make_move(board)
    swap_players_if_move_made(board, new_board, players) |> _play_game(new_board, display)
  end

  defp players(choice), do: PlayersFactory.get_players_for(choice)

  defp get_first_player(players), do: List.first(players)
  defp get_move_from_player(player, setup), do: player.get_move(setup)
  defp make_move(move, board), do: @board.mark_position(move, @board.current_mark(board), board)

  defp swap_players_if_move_made(old_board, new_board, players) when old_board == new_board, do: players
  defp swap_players_if_move_made(_, _, players), do: Enum.reverse(players)
end
