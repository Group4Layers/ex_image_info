defmodule ExImageInfoTest.Images.GIFTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "gif87a" => TestHelper.read_image("valid/gif/layers-87a.gif"), # interlace
      "gif89a" => TestHelper.read_image("valid/gif/layers.gif"),
      "gif-anim" => TestHelper.read_image("valid/gif/layers-anim.gif"),
    }
    {:ok, images}
  end


  test "force - gif (gif87a, gif89a) disk image - #seems? #type #info", images do
    assert seems?(images["gif87a"], :gif) == true
    assert seems?(images["gif89a"], :gif) == true
    assert type(images["gif87a"], :gif) == {"image/gif", "GIF87a"}
    assert type(images["gif89a"], :gif) == {"image/gif", "GIF89a"}
    assert info(images["gif87a"], :gif) == {"image/gif", 130, 42, "GIF87a"}
    assert info(images["gif89a"], :gif) == {"image/gif", 130, 42, "GIF89a"}
  end

  test "guess - gif (gif87a, gif89a) disk image - #seems? #type #info", images do
    # IO.inspect images["gif89a"], base: :hex
    assert seems?(images["gif87a"]) == :gif
    assert seems?(images["gif89a"]) == :gif
    assert type(images["gif87a"]) == {"image/gif", "GIF87a"}
    assert type(images["gif89a"]) == {"image/gif", "GIF89a"}
    assert info(images["gif87a"]) == {"image/gif", 130, 42, "GIF87a"}
    assert info(images["gif89a"]) == {"image/gif", 130, 42, "GIF89a"}
  end

  test "gif (anim) disk image - #seems? #type #info", images do
    assert seems?(images["gif-anim"], :gif) == true
    assert type(images["gif-anim"], :gif) == {"image/gif", "GIF89a"}
    assert info(images["gif-anim"], :gif) == {"image/gif", 130, 42, "GIF89a"}
  end
end
