defmodule ExImageInfoTest.Images.TIFFTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "tiff" => TestHelper.read_image("valid/tiff/layers.tiff"),
      "i-s-big-endian" => TestHelper.read_image("valid/tiff/i-s-big-endian.tiff"), # i-s: image-size
      "tiff-deflate" => TestHelper.read_image("valid/tiff/layers-deflate.tiff"),
      "tiff-jpeg" => TestHelper.read_image("valid/tiff/layers-jpeg.tiff"),
      "tiff-lzw" => TestHelper.read_image("valid/tiff/layers-lzw.tiff"),
      "tiff-packbits" => TestHelper.read_image("valid/tiff/layers-packbits.tiff"),
    }
    {:ok, images}
  end

  test "force - tiff disk image (no compression) - #seems? #type #info", images do
    assert seems?(images["tiff"], :tiff) == true
    assert type(images["tiff"], :tiff) == {"image/tiff", "TIFFII"}
    assert info(images["tiff"], :tiff) == {"image/tiff", 130, 42, "TIFFII"}
  end

  test "force - tiff disk image (big-endian) - #seems? #type #info", images do
    assert seems?(images["i-s-big-endian"], :tiff) == true
    assert type(images["i-s-big-endian"], :tiff) == {"image/tiff", "TIFFMM"}
    assert info(images["i-s-big-endian"], :tiff) == {"image/tiff", 123, 456, "TIFFMM"}
  end

  test "force - tiff disk image (deflate compression) - #seems? #type #info", images do
    assert seems?(images["tiff-deflate"], :tiff) == true
    assert type(images["tiff-deflate"], :tiff) == {"image/tiff", "TIFFII"}
    assert info(images["tiff-deflate"], :tiff) == {"image/tiff", 130, 42, "TIFFII"}
  end

  test "force - tiff disk image (jpeg compression) - #seems? #type #info", images do
    assert seems?(images["tiff-jpeg"], :tiff) == true
    assert type(images["tiff-jpeg"], :tiff) == {"image/tiff", "TIFFII"}
    assert info(images["tiff-jpeg"], :tiff) == {"image/tiff", 130, 42, "TIFFII"}
  end

  test "force - tiff disk image (lzw compression) - #seems? #type #info", images do
    assert seems?(images["tiff-lzw"], :tiff) == true
    assert type(images["tiff-lzw"], :tiff) == {"image/tiff", "TIFFII"}
    assert info(images["tiff-lzw"], :tiff) == {"image/tiff", 130, 42, "TIFFII"}
  end

  test "force - tiff disk image (packbits compression) - #seems? #type #info", images do
    assert seems?(images["tiff-packbits"], :tiff) == true
    assert type(images["tiff-packbits"], :tiff) == {"image/tiff", "TIFFII"}
    assert info(images["tiff-packbits"], :tiff) == {"image/tiff", 130, 42, "TIFFII"}
  end
end
