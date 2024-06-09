defmodule ExImageInfoTest.Mocks.JP2Test do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "jp2" => <<
        0x00,
        0x00,
        0x00,
        0x0C,
        0x6A,
        0x50,
        0x20,
        0x20,
        0x0D,
        0x0A,
        0x87,
        0x0A,
        0x00,
        0x00,
        0x00,
        0x14,
        0x66,
        0x74,
        0x79,
        0x70,
        0x6A,
        0x70,
        0x32,
        0x00,
        # 20 * 8
        0::size(160),
        "ihdr",
        # height
        457::size(32),
        # width
        134::size(32)
      >>
    }

    {:ok, images}
  end

  test "force - jp2 (jpeg 2000) binary mock - #seems? #type #info", images do
    assert seems?(images["jp2"], :jp2) == true
    assert type(images["jp2"], :jp2) == {"image/jp2", "JP2"}
    assert info(images["jp2"], :jp2) == {"image/jp2", 134, 457, "JP2"}
  end

  test "guess - jp2 (jpeg 2000) binary mock - #seems? #type #info", images do
    assert seems?(images["jp2"]) == :jp2
    assert type(images["jp2"]) == {"image/jp2", "JP2"}
    assert info(images["jp2"]) == {"image/jp2", 134, 457, "JP2"}
  end
end
