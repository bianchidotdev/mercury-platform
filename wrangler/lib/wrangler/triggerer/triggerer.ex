defmodule Wrangler.Triggerer do
  def triggers do
    trigger_sources()
    |> Enum.map(fn {provider, source_name} -> provider.pull_triggers(source_name) end)
  end

  def trigger_sources do
    [{Wrangler.GCPClient, Application.get_env(:wrangler, :trigger_bucket)}]
  end
end
