defmodule ExImageInfoTest.Mocks.PNGTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "png" => <<
        0x89,
        0x50,
        0x4E,
        0x47,
        0x0D,
        0x0A,
        0x1A,
        0x0A,
        # 0x00, 0x00, 0x00, 0x00,
        0::size(32),
        "IHDR",
        # 0x00, 0x00, 0x00, 0x00,
        # 0x00_00_00_00::size(32),
        # 0::size(32),
        134::size(32),
        457::size(32),
        0
      >>
    }

    {:ok, images}
  end

  test "force - png binary mock - #seems? #type #info", images do
    assert seems?(images["png"], :png) == true
    assert type(images["png"], :png) == {"image/png", "PNG"}
    assert info(images["png"], :png) == {"image/png", 134, 457, "PNG"}
  end

  test "guess - png binary mock - #seems? #type #info", images do
    assert seems?(images["png"]) == :png
    assert type(images["png"]) == {"image/png", "PNG"}
    assert info(images["png"]) == {"image/png", 134, 457, "PNG"}
  end
end
