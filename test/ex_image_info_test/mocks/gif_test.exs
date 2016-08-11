defmodule ExImageInfoTest.Mocks.GIFTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "gif89a" => <<0x47, 0x49, 0x46, 0x38, 0x39, 0x61, 123::little-size(16), 456::little-size(16)>>,
      "gif87a" => <<0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 134::little-size(16), 457::little-size(16)>>,
    }
    {:ok, images}
  end

  test "force - gif (gif87a, gif89a) binary mock - #seems? #type #info", images do
    assert seems?(images["gif87a"], :gif) == true
    assert seems?(images["gif89a"], :gif) == true
    assert type(images["gif87a"], :gif) == {"image/gif", "GIF87a"}
    assert type(images["gif89a"], :gif) == {"image/gif", "GIF89a"}
    assert info(images["gif87a"], :gif) == {"image/gif", 134, 457, "GIF87a"}
    assert info(images["gif89a"], :gif) == {"image/gif", 123, 456, "GIF89a"}
  end

  test "guess - gif (gif87a, gif89a) binary mock - #seems? #type #info", images do
    # IO.inspect images["gif89a"], base: :hex
    assert seems?(images["gif87a"]) == :gif
    assert seems?(images["gif89a"]) == :gif
    assert type(images["gif87a"]) == {"image/gif", "GIF87a"}
    assert type(images["gif89a"]) == {"image/gif", "GIF89a"}
    assert info(images["gif87a"]) == {"image/gif", 134, 457, "GIF87a"}
    assert info(images["gif89a"]) == {"image/gif", 123, 456, "GIF89a"}
  end

end
