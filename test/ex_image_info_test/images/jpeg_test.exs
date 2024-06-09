defmodule ExImageInfoTest.Images.JPEGTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "jpegBase" => TestHelper.read_image("valid/jpeg/layers.jpeg"),
      # optimize, progressive
      "jpegProg" => TestHelper.read_image("valid/jpeg/layers-progressive.jpeg")
    }

    {:ok, images}
  end

  test "force - jpeg (baseline, progressive) disk image - #seems? #type #info",
       images do
    assert seems?(images["jpegBase"], :jpeg) == true
    assert seems?(images["jpegProg"], :jpeg) == true
    assert type(images["jpegBase"], :jpeg) == {"image/jpeg", "baseJPEG"}
    assert type(images["jpegProg"], :jpeg) == {"image/jpeg", "progJPEG"}
    assert info(images["jpegBase"], :jpeg) == {"image/jpeg", 130, 42, "baseJPEG"}
    assert info(images["jpegProg"], :jpeg) == {"image/jpeg", 130, 42, "progJPEG"}
  end

  test "guess - jpeg (baseline, progressive) disk image - #seems? #type #info",
       images do
    assert seems?(images["jpegBase"]) == :jpeg
    assert seems?(images["jpegProg"]) == :jpeg
    assert type(images["jpegBase"]) == {"image/jpeg", "baseJPEG"}
    assert type(images["jpegProg"]) == {"image/jpeg", "progJPEG"}
    assert info(images["jpegBase"]) == {"image/jpeg", 130, 42, "baseJPEG"}
    assert info(images["jpegProg"]) == {"image/jpeg", 130, 42, "progJPEG"}
  end

  test "force - alias jpg (baseline, progressive) disk image - #seems? #type #info",
       images do
    assert seems?(images["jpegBase"], :jpg) == true
    assert seems?(images["jpegProg"], :jpg) == true
    assert type(images["jpegBase"], :jpg) == {"image/jpeg", "baseJPEG"}
    assert type(images["jpegProg"], :jpg) == {"image/jpeg", "progJPEG"}
    assert info(images["jpegBase"], :jpg) == {"image/jpeg", 130, 42, "baseJPEG"}
    assert info(images["jpegProg"], :jpg) == {"image/jpeg", 130, 42, "progJPEG"}
  end
end
