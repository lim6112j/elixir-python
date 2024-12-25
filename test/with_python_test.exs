defmodule WithPythonTest do
  use ExUnit.Case
  doctest WithPython

  test "greets the world" do
    assert WithPython.hello() == :world
  end
end
