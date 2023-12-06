defmodule ExImageInfoTest.Mocks.BMPTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "bmp" => << "BM",
      0::size(128), # 16 bytes offset
      134::little-size(16),
      0::size(16), # skip
      457::little-size(16),
      >>,
    }
    {:ok, images}
  end

  test "force - bmp binary mock - #seems? #type #info", images do
    assert seems?(images["bmp"], :bmp) == true
    assert type(images["bmp"], :bmp) == {"image/bmp", "BMP"}
    assert info(images["bmp"], :bmp) == {"image/bmp", 134, 457, "BMP"}
  end

  test "guess - bmp binary mock - #seems? #type #info", images do
    assert seems?(images["bmp"]) == :bmp
    assert type(images["bmp"]) == {"image/bmp", "BMP"}
    assert info(images["bmp"]) == {"image/bmp", 134, 457, "BMP"}
  end
end
