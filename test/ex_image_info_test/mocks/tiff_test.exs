defmodule ExImageInfoTest.Mocks.TIFFTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "tiffII" => << 0x49492A00::size(32), # little endian
      0x0C000000::size(32),
      0xffffff001000fe00::size(64),
      0x04000100000000000000000103000100::size(128),
      0x00000100000001010300010000000100::size(128),
      0x00000201030003000000e20000000301::size(128),
      0x03000100000001000000060103000100::size(128),
      0x0000020000000d01020055000000e800::size(128),
      0x00001101040001000000080000001201::size(128),
      0x03000100000001000000150103000100::size(128),
      0x00000300000016010300010000004000::size(128),
      0x00001701040001000000030000001a01::size(128),
      0x050001000000d20000001b0105000100::size(128),
      0x0000da0000001c010300010000000100::size(128),
      0x00002801030001000000020000000000::size(128),
      0x00006000000001000000600000000100::size(128),
      0x00000800080008002f6d6e742f646174::size(128),
      0x612f7265706f7369746f726965732f65::size(128),
      0x6c697869722f65785f696d6167655f73::size(128),
      0x697a652f746573742f66697874757265::size(128),
      0x732f696d616765732f76616c69642f74::size(128),
      0x6966662f6f6e652e7469666600::size(104),
      >>,
      "tiffMM" => << 0x4D4D002A::size(32), # big endian
      0x00,
      >>,
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
