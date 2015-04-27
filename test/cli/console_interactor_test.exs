defmodule CLI.ConsoleInteractorTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @console_interactor CLI.ConsoleInteractor

  test "parses a string to a number" do
    assert @console_interactor.convert_to_number("1\n") == {1, "\n"}
  end

  test "returns error if parsing invalid input" do
    assert @console_interactor.convert_to_number("invalid\n") == :error
  end

  test "prompts the user for input" do
    message = capture_io([input: "1"], fn ->
      IO.write @console_interactor.prompt_user_with_message("Please choose valid move: ")
    end)
    assert message_contains_string(message, "Please choose valid move:")
    assert message_contains_string(message, "1")
  end

  defp message_contains_string(message, string) do
    String.contains?(message, string)
  end
end
