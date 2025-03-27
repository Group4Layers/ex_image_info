defmodule ImageTestCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  @doc "Reads an image giving a relative path to test/fixtures/images"
  def read_image(rel_path) do
    abs_path = Path.expand(Path.join("test/fixtures/images", rel_path), File.cwd!())
    File.read!(abs_path)
  end

  using do
    quote do
      use ExUnit.Case, async: true

      def read_image(rel_path), do: ImageTestCase.read_image(rel_path)
    end
  end
end
