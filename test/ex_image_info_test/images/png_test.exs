defmodule ExImageInfoTest.Images.PNGTest do
  use ImageTestCase

  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "png" => read_image("valid/png/layers.png")
    }

    {:ok, images}
  end

  test "force - png disk image - #seems? #type #info", images do
    assert seems?(images["png"], :png) == true
    assert type(images["png"], :png) == {"image/png", "PNG"}
    assert info(images["png"], :png) == {"image/png", 130, 42, "PNG"}
  end

  test "guess - png disk image - #seems? #type #info", images do
    assert seems?(images["png"]) == :png
    assert type(images["png"]) == {"image/png", "PNG"}
    assert info(images["png"]) == {"image/png", 130, 42, "PNG"}
  end
end
