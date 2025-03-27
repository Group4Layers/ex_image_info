defmodule ImageTestCase do
  @moduledoc false

  defmacro __using__(opts) do
    quote do
      use ExUnit.Case, async: async?

      import ImageTestCase

      async? = Keyword.get(unquote(opts), :async, true)
    end
  end

  @doc "Reads an image giving a relative path to test/fixtures/images"
  def read_image(rel_path) do
    abs_path = Path.expand(Path.join("test/fixtures/images", rel_path), File.cwd!())
    File.read!(abs_path)
  end
end
