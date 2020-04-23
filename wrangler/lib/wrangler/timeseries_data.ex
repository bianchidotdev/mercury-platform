defmodule Wrangler.TimeseriesData do
  defstruct [:symbol, :date, :open, :close, :high, :low]
end

defimpl CSV.Encode, for: Wrangler.TimeseriesData do
  def encode(data, env \\ []) do
    
    [data[:symbol], data[:date], data[:open], data[:close], data[:high], data[:low]]
      |> CSV.Encode.encode(env)
  end
end
