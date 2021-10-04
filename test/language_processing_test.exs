defmodule LanguageProcessingTest do
  use ExUnit.Case
  doctest LanguageProcessing

  test "greets the world" do
    assert LanguageProcessing.hello() == :world
  end
end
