defmodule CLI.Colorizer do
  def colorize(string, color), do: Colorful.string(string, color)
end
