defmodule ExImageInfoTest.Images.BMPTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "bmp" => TestHelper.read_image("valid/bmp/layers.bmp"),
    }
    {:ok, images}
  end

  # @tag :wip
  test "force - bmp disk image - #seems? #type #info", images do
    assert seems?(images["bmp"], :bmp) == true
    assert type(images["bmp"], :bmp) == {"image/bmp", "BMP"}
    assert info(images["bmp"], :bmp) == {"image/bmp", 130, 42, "BMP"}
  end

  # @tag :wip
  test "guess - bmp disk image - #seems? #type #info", images do
    assert seems?(images["bmp"]) == :bmp
    assert type(images["bmp"]) == {"image/bmp", "BMP"}
    assert info(images["bmp"]) == {"image/bmp", 130, 42, "BMP"}
  end

end
