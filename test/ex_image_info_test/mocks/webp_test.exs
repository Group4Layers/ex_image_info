defmodule ExImageInfoTest.Mocks.WEBPTest do
  use ExUnit.Case, async: true

  import ExImageInfo

  setup_all do
    images = %{
      "webpVP8" => <<
        "RIFF",
        0::size(32),
        "WEBP",
        "VP8",
        " ",
        0::size(32),
        # 0x22, # not 0x2f
        0x70,
        0::size(40),
        # 0x7b00::size(16),
        134::little-size(16),
        457::little-size(16)
        # 0xc801::size(16),
        # 0x005f::little-size(16),
        # 0x00ff::little-size(16),
        # 0x0f::little-size(8),
        # 0x03::little-size(8),
        # 0x07,
        # 0x04::little-size(8),
      >>,
      "webpVP8L" => <<
        "RIFF",
        0::size(32),
        "WEBP",
        "VP8L",
        0::size(32),
        # 0x22, # not 0x2f
        # 0::size(24),
        # 0x70,
        # 0::size(40),
        # 0x9d,
        # 0x01,
        # 0x22, # 0x2a is invalid
        # 0x7b00::size(16),
        # 134::little-size(16),
        # 457::little-size(16),
        0x2F,
        0x7A,
        0xC0,
        0x71,
        0x00,
        0x35,
        0x86,
        0x83,
        0xB6,
        0x8D
      >>,
      "webpVP8Linv" => <<
        "RIFF",
        0::size(32),
        "WEBP",
        "VP8L",
        0::size(32),
        # 0x22, # not 0x2f
        0::size(24),
        # 0x70,
        # 0::size(40),
        0x9D,
        0x01,
        0x2A,
        # 0x7b00::size(16),
        134::little-size(16),
        457::little-size(16)
      >>
    }

    {:ok, images}
  end

  test "force - webp binary mock - #seems? #type #info", images do
    assert seems?(images["webpVP8"], :webp) == true
    assert seems?(images["webpVP8L"], :webp) == true
    assert type(images["webpVP8"], :webp) == {"image/webp", "webpVP8"}
    assert type(images["webpVP8L"], :webp) == {"image/webp", "webpVP8L"}
    assert info(images["webpVP8"], :webp) == {"image/webp", 134, 457, "webpVP8"}
    assert info(images["webpVP8L"], :webp) == {"image/webp", 123, 456, "webpVP8L"}
  end
end
