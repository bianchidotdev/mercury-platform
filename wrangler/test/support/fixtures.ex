defmodule Wrangler.Fixtures do
  @moduledoc """
  A module for defining fixtures that can be used in tests.
  This module can be used with a list of fixtures to apply as parameter:
      use Kakte.Fixtures, [:user]
  """

  @fixture_path File.cwd! <> "/test/fixtures/"

  def fixture(file) do
    File.read!(@fixture_path <> file)
  end
end
