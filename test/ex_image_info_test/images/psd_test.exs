defmodule ExImageInfoTest.Images.PSDTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "psd" => TestHelper.read_image("valid/psd/layers.psd"),
    }
    {:ok, images}
  end

  test "force - psd disk image - #seems? #type #info", images do
    assert seems?(images["psd"], :psd) == true
    assert type(images["psd"], :psd) == {"image/psd", "PSD"}
    assert info(images["psd"], :psd) == {"image/psd", 130, 42, "PSD"}
  end

end
