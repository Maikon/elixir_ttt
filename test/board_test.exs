defmodule BoardTest do
  use ExUnit.Case

  test "supports 3x3 by default" do
    assert Board.new == [0, 1, 2,
                         3, 4, 5,
                         6, 7, 8]
  end

  test "size can vary" do
    assert Board.new(4) == [0, 1, 2, 3,
                            4, 5, 6, 7,
                            8, 9, 10, 11,
                            12, 13, 14, 15]
  end
end
