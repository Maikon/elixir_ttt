defmodule ComputerPlayer do
  @board Board
  @initial_depth 0
  @initial_score 10.0
  @alpha -@initial_score
  @beta   @initial_score

  def get_move(%{board: board}) do
    negamax(board, @initial_depth, @alpha, @beta)[:move]
  end

  defp rated_node_template(alpha, beta) do
    %{:score => -@initial_score,
      :board => [],
      :move => -1,
      :alpha => alpha,
      :beta => beta
    }
  end

  defp negamax(board, depth, alpha, beta) do
    if @board.status(board) == :over do
      %{:score => score(board), :board => board}
    else
      board
      |> get_nodes
      |> Enum.reduce(rated_node_template(alpha, beta), fn(node, template) ->
        _negamax(template, node, depth, alpha, beta)
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

  defp _negamax(rated_node, new_node, depth, alpha, beta) do
    if rated_node[:alpha] >= rated_node[:beta] do
      rated_node
    else
      %{score: score} = negamax(new_node[:board], depth + 1, -rated_node[:beta], -rated_node[:alpha])
      negated_score = -score
      if negated_score > rated_node[:score] do
        %{:score => negated_score,
          :board => new_node[:board],
          :move => new_node[:move],
          :alpha => negated_score,
          :beta => rated_node[:beta]
        }
      else
        rated_node
      end
    end
  end

  defp score(board) do
    if @board.winner(board) do
      -(@initial_score / @board.moves_left(board))
    else
      0
    end
  end
end
