defmodule Wrangler.Factory do
  use ExMachina

  def timeseries_data_factory do
    %Wrangler.TimeseriesData{
      symbol: "GOOG",
      date: sequence("date", &date_sequence/1),
      # &Date.new(2020, 04, 25) |> Date.add(Integer.parse(&1))),
      open: "",
      high: "",
      low: "",
      close: ""
    }
  end

  def date_sequence(seq) do
    Date.add(~D[2020-04-25], seq)
  end
end
