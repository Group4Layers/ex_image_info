defmodule ExImageInfoTest.Mocks.JPEGTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "jpegBase" => << 0xFF, 0xD8,
      0xFF, 0xE8, # skip
      0x00, 0x03, # block length
      0x00, # content (as set in block length - 2)
      0xFF, # static
      0xC0, # 0xC0, 0xC2
      0x00, 0x00, 0x00, # _skip
      457::size(16), # height
      134::size(16), # width
      >>,
      "jpegProg" => << 0xFF, 0xD8,
      0xFF, 0xC2, # skip
      0x00, 0x03, # block length
      0x00, # content (as set in block length - 2 - the size of the length itself)
      0xFF, # static
      0xC2, # 0xC0, 0xC2
      0x00, 0x00, 0x00, # _skip
      457::size(16), # height
      134::size(16), # width
      # 0x00, 0x05, # height
      # 0x00, 0x08, # width
      >>,
    }
    {:ok, images}
  end

  test "force - jpeg (baseline, progressive) binary mock - #seems? #type #info", images do
    assert seems?(images["jpegBase"], :jpeg) == true
    assert seems?(images["jpegProg"], :jpeg) == true
    assert type(images["jpegBase"], :jpeg) == {"image/jpeg", "baseJPEG"}
    assert type(images["jpegProg"], :jpeg) == {"image/jpeg", "progJPEG"}
    assert info(images["jpegBase"], :jpeg) == {"image/jpeg", 134, 457, "baseJPEG"}
    assert info(images["jpegProg"], :jpeg) == {"image/jpeg", 134, 457, "progJPEG"}
  end

  test "guess - jpeg (baseline, progressive) binary mock - #seems? #type #info", images do
    assert seems?(images["jpegBase"]) == :jpeg
    assert seems?(images["jpegProg"]) == :jpeg
    assert type(images["jpegBase"]) == {"image/jpeg", "baseJPEG"}
    assert type(images["jpegProg"]) == {"image/jpeg", "progJPEG"}
    assert info(images["jpegBase"]) == {"image/jpeg", 134, 457, "baseJPEG"}
    assert info(images["jpegProg"]) == {"image/jpeg", 134, 457, "progJPEG"}
  end
end
