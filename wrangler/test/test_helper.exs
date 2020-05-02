{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.configure exclude: [:integration_only]
ExUnit.start()
