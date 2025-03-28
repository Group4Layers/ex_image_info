defmodule ImageTestCase do
  @moduledoc false

  defmacro __using__(opts) do
    async? = Keyword.get(opts, :async, true)

    quote bind_quoted: [async?: async?] do
      use ExUnit.Case, async: async?

      import ImageTestCase
    end
  end

  @doc "Reads an image giving a relative path to test/fixtures/images"
  def read_image(rel_path) do
    abs_path = Path.expand(Path.join("test/fixtures/images", rel_path), File.cwd!())
    File.read!(abs_path)
  end
end
