defmodule Wrangler.ParquetSerializer do
  # use Rustler, otp_app: :wrangler, crate: "parquetserializer"

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def write_parquet(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
