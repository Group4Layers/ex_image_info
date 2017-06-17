defmodule ExImageInfoTest.Mocks.ICOTest do
  use ExUnit.Case, async: true
  import ExImageInfo
  # doctest ExImageInfo.Detector

  setup_all do
    images = %{
      "ico" => << 0x00, 0x00,
      0x01, 0x00, # .ICO = 1
      0x01, 0x00, # 1 image
      # first image
      0x86, # width 0 => 256
      0x39, # height 0 => 256
      # rest
      0::size(112), # 14 bytes
      0x00,
      >>,
      "ico-256" => << 0x00, 0x00,
      0x01, 0x00, # .ICO = 1
      0x02, 0x00, # 2 images, but only "parsed" the first one
      # first image
      0x86, # width
      0x39, # height
      0::size(112), # 14 bytes
      # second image
      0x0, # width 0 => 256
      0x0, # height 0 => 256
      0::size(112), # 14 bytes
      # rest
      0x00,
      >>,
    }
    {:ok, images}
  end

  # @tag :wip
  test "force - ico binary mock - #seems? #type #info", images do
    assert seems?(images["ico"], :ico) == true
    assert seems?(images["ico-256"], :ico) == true
    assert type(images["ico"], :ico) == {"image/x-icon", "ICO"}
    assert type(images["ico-256"], :ico) == {"image/x-icon", "ICO"}
    assert info(images["ico"], :ico) == {"image/x-icon", 134, 57, "ICO"}
    assert info(images["ico-256"], :ico) == {"image/x-icon", 256, 256, "ICO"}
  end

  # @tag :wip
  test "guess - ico binary mock - #seems? #type #info", images do
    assert seems?(images["ico"]) == :ico
    assert seems?(images["ico-256"]) == :ico
    assert type(images["ico"]) == {"image/x-icon", "ICO"}
    assert type(images["ico-256"]) == {"image/x-icon", "ICO"}
    assert info(images["ico"]) == {"image/x-icon", 134, 57, "ICO"}
    # It picks the largest image in the .ICO (in this mock, the second)
    assert info(images["ico-256"]) == {"image/x-icon", 256, 256, "ICO"}
  end

end
