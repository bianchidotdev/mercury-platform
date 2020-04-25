defmodule Wrangler.Fetcher do
  def pull_symbol(symbol) do
    source = source_for_symbol(symbol)
    source.pull_symbol(symbol)
  end

  def source_for_symbol(_symbol) do
    Wrangler.AlphaVantageClient
  end
end
