defmodule WranglerTest do
  use ExUnit.Case
  doctest Wrangler

  test "greets the world" do
    assert Wrangler.hello() == :world
  end
end
