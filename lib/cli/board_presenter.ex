defmodule CLI.BoardPresenter do
  @colorizer CLI.Colorizer

  def show(board) do
    board
    |> Enum.with_index
    |> Enum.map(fn(position) ->
      position
      |> _get_value
      |> _set_correct_color
    end)
    |> _show_board
  end

  defp _get_value({position, index}) when position == "", do: index + 1
  defp _get_value({position, _}), do: position

  defp _set_correct_color(mark) when mark == "x", do: @colorizer.colorize(mark, :red)
  defp _set_correct_color(mark) when mark == "o", do: @colorizer.colorize(mark, :green)
  defp _set_correct_color(mark), do: mark

  defp _show_board([a1, a2, a3,
                    b1, b2, b3,
                    c1, c2, c3]), do: IO.write "#{a1} | #{a2} | #{a3}\n" <>
                                               "---------\n"             <>
                                               "#{b1} | #{b2} | #{b3}\n" <>
                                               "---------\n"             <>
                                               "#{c1} | #{c2} | #{c3}\n"
end
