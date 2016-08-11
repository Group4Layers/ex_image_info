defmodule ExImageInfoTest.Images.JPEGTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "jpegBase" => TestHelper.read_image("valid/jpeg/layers.jpeg"),
      "jpegProg" => TestHelper.read_image("valid/jpeg/layers-progressive.jpeg"), # optimize, progressive
    }
    {:ok, images}
  end

  # @tag :wip
  test "force - jpeg (baseline, progressive) disk image - #seems? #type #info", images do
    assert seems?(images["jpegBase"], :jpeg) == true
    assert seems?(images["jpegProg"], :jpeg) == true
    assert type(images["jpegBase"], :jpeg) == {"image/jpeg", "baseJPEG"}
    assert type(images["jpegProg"], :jpeg) == {"image/jpeg", "progJPEG"}
    assert info(images["jpegBase"], :jpeg) == {"image/jpeg", 130, 42, "baseJPEG"}
    assert info(images["jpegProg"], :jpeg) == {"image/jpeg", 130, 42, "progJPEG"}
  end

  # @tag :wip
  test "guess - jpeg (baseline, progressive) disk image - #seems? #type #info", images do
    assert seems?(images["jpegBase"]) == :jpeg
    assert seems?(images["jpegProg"]) == :jpeg
    assert type(images["jpegBase"]) == {"image/jpeg", "baseJPEG"}
    assert type(images["jpegProg"]) == {"image/jpeg", "progJPEG"}
    assert info(images["jpegBase"]) == {"image/jpeg", 130, 42, "baseJPEG"}
    assert info(images["jpegProg"]) == {"image/jpeg", 130, 42, "progJPEG"}
  end

end