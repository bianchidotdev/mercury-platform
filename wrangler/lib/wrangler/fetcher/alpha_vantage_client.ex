defmodule Wrangler.AlphaVantageClient do
  def pull_symbol(sym) do
    resp = Vantagex.TimeSeries.daily_adjusted(sym, outputsize: "full")
    handle_resp(resp)
  end

  def handle_resp(resp) do
    case resp do
      %{"Error Message" => error} ->
        {:error, error}

      %{
        "Meta Data" => metadata,
        "Time Series (Daily)" => timeseries
      } ->
        {:ok, handle_success(metadata, timeseries)}
    end
  end

  def handle_success(metadata, timeseries) do
    symbol = metadata["2. Symbol"]

    timeseries
    |> Enum.map(&map_to_data_struct(symbol, &1))
  end

  def map_to_data_struct(symbol, {date, data}) do
    %{
      "1. open" => open,
      "2. high" => high,
      "3. low" => low,
      "4. close" => close,
      "5. adjusted close" => _adjusted_close,
      "6. volume" => _volume,
      "7. dividend amount" => _divident_amount,
      "8. split coefficient" => _split_coefficient
    } = data

    %Wrangler.TimeseriesData{
      symbol: symbol,
      date: date,
      open: open,
      high: high,
      low: low,
      close: close
    }
  end
end
