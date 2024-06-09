defmodule TestHelper do
  def read_image(rel_path) do
    abs_path = Path.expand(Path.join("test/fixtures/images", rel_path), File.cwd!())
    File.read!(abs_path)
  end
end

ExUnit.start()
