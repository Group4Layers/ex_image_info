defmodule ExImageInfoTest.Images.JP2Test do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "jp2" => TestHelper.read_image("valid/jp2/layers.jp2")
    }

    {:ok, images}
  end

  test "force - jp2 (jpeg 2000) disk image - #seems? #type #info", images do
    assert seems?(images["jp2"], :jp2) == true
    assert type(images["jp2"], :jp2) == {"image/jp2", "JP2"}
    assert info(images["jp2"], :jp2) == {"image/jp2", 130, 42, "JP2"}
  end

  test "guess - jp2 (jpeg 2000) disk image - #seems? #type #info", images do
    assert seems?(images["jp2"]) == :jp2
    assert type(images["jp2"]) == {"image/jp2", "JP2"}
    assert info(images["jp2"]) == {"image/jp2", 130, 42, "JP2"}
  end
end
