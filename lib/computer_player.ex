defmodule ComputerPlayer do
  @board Board
  @initial_depth 0
  @rated_node_template %{:score => -10.0, :board => [], :move => -1}

  def get_move(%{board: board}) do
    available_moves = @board.available_moves(board)
    if many_available_moves(available_moves) do
      available_moves |> pick_random_move
    else
      negamax(board, @initial_depth)[:move]
    end
  end

  defp many_available_moves(available_moves) do
    Enum.count(available_moves) >= 9
  end

  defp pick_random_move(available_moves) do
    available_moves |> Enum.shuffle |> List.first
  end

  defp negamax(board, depth) do
    if @board.status(board) == :over do
      %{:score => score(board), :board => board}
    else
      board
      |> get_nodes
      |> Enum.reduce(@rated_node_template, fn(node, template) ->
        _negamax(template, node, depth)
      end)
    end
  end

  defp get_nodes(board) do
    board
    |> @board.available_moves
    |> Enum.map(fn(move) ->
      %{:board => get_new_board_with(move, board),
        :move  => move}
    end)
  end

  defp get_new_board_with(move, board) do
    @board.mark_position(move, @board.current_mark(board), board)
  end

  defp _negamax(template, node, depth) do
    %{score: score} = negamax(node[:board], depth + 1)
    negated_score = -score
    if negated_score > template[:score] do
      %{:score => negated_score, :board => node[:board], :move => node[:move]}
    else
      template
    end
  end

  defp score(board) do
    if @board.winner(board) do
      -(10.0 / @board.moves_left(board))
    else
      0
    end
  end
end
