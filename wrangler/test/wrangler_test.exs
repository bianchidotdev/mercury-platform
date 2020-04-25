defmodule WranglerTest do
  use ExUnit.Case
  doctest Wrangler

  import Wrangler.Factory

  setup do
    ExMachina.Sequence.reset()
  end

  test "greets the world" do
    assert Wrangler.hello() == :world
  end

  test "timeseries data factory exists" do
    build(:timeseries_data)
  end

  test "timeseries date sequence works" do
    data = build_list(10, :timeseries_data)
    last = data |> List.last()
    assert last.date == ~D[2020-05-04]
  end
end
