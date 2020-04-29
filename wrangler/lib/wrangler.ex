defmodule Wrangler do
  @moduledoc """
  Documentation for `Wrangler`.
  """
  
  @doc """
  Hello world.
  
  ## Examples
  
  iex> Wrangler.hello()
  :world
  
  """
  def hello do
    :world
  end

  def run do
    Wrangler.Triggerer.triggers()
  end

  def pull_and_store(symbol) do
    Wrangler.Fetcher.pull_symbol(symbol)
    |> Wrangler.Saver.store_timeseries_data()
  end
end
