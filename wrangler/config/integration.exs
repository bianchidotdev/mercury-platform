use Mix.Config
import_config "test.exs"

config :tesla,
  adapter: {Tesla.Adapter.Hackney, ssl_options: [verify: :verify_none]}
