defmodule ExImageInfoTest.Mocks.TIFFTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # little endian
      "tiffII" =>
        <<0x49492A00::size(32), 0x0C000000::size(32), 0xFFFFFF001000FE00::size(64),
          0x04000100000000000000000103000100::size(128),
          0x00000100000001010300010000000100::size(128),
          0x00000201030003000000E20000000301::size(128),
          0x03000100000001000000060103000100::size(128),
          0x0000020000000D01020055000000E800::size(128),
          0x00001101040001000000080000001201::size(128),
          0x03000100000001000000150103000100::size(128),
          0x00000300000016010300010000004000::size(128),
          0x00001701040001000000030000001A01::size(128),
          0x050001000000D20000001B0105000100::size(128),
          0x0000DA0000001C010300010000000100::size(128),
          0x00002801030001000000020000000000::size(128),
          0x00006000000001000000600000000100::size(128),
          0x00000800080008002F6D6E742F646174::size(128),
          0x612F7265706F7369746F726965732F65::size(128),
          0x6C697869722F65785F696D6167655F73::size(128),
          0x697A652F746573742F66697874757265::size(128),
          0x732F696D616765732F76616C69642F74::size(128),
          0x6966662F6F6E652E7469666600::size(104)>>,
      # big endian
      "tiffMM" => <<0x4D4D002A::size(32), 0x00>>
    }

    {:ok, images}
  end

  test "force - tiff binary mock - #seems? #type #info", images do
    assert seems?(images["tiffII"], :tiff) == true
    assert seems?(images["tiffMM"], :tiff) == true
    assert type(images["tiffII"], :tiff) == {"image/tiff", "TIFFII"}
    assert type(images["tiffMM"], :tiff) == {"image/tiff", "TIFFMM"}
    assert info(images["tiffII"], :tiff) == {"image/tiff", 1, 1, "TIFFII"}
  end
end
