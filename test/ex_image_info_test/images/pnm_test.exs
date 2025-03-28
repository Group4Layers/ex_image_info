defmodule ExImageInfoTest.Images.PNMTest do
  use ImageTestCase

  import ExImageInfo

  setup_all do
    images = %{
      "pbm" => read_image("valid/pnm/layers.pbm"),
      "pbm-plain" => read_image("valid/pnm/plain.pbm"),
      "pgm" => read_image("valid/pnm/layers.pgm"),
      "pgm-plain" => read_image("valid/pnm/plain.pgm"),
      "ppm" => read_image("valid/pnm/layers.ppm"),
      "ppm-plain" => read_image("valid/pnm/plain.ppm")
    }

    {:ok, images}
  end

  test "force - pnm (pbm - bitmap) disk image (+ plain) - #seems? #type #info",
       images do
    assert seems?(images["pbm"], :pnm) == true
    assert seems?(images["pbm-plain"], :pnm) == true
    assert type(images["pbm"], :pnm) == {"image/x-portable-anymap", "PNMpbm"}
    assert type(images["pbm-plain"], :pnm) == {"image/x-portable-anymap", "PNMpbm"}
    assert info(images["pbm"], :pnm) == {"image/x-portable-anymap", 130, 42, "PNMpbm"}

    assert info(images["pbm-plain"], :pnm) ==
             {"image/x-portable-anymap", 3, 11, "PNMpbm"}
  end

  test "force - pnm (pgm - graymap) disk image (+ plain) - #seems? #type #info",
       images do
    assert seems?(images["pgm"], :pnm) == true
    assert seems?(images["pgm-plain"], :pnm) == true
    assert type(images["pgm"], :pnm) == {"image/x-portable-anymap", "PNMpgm"}
    assert type(images["pgm-plain"], :pnm) == {"image/x-portable-anymap", "PNMpgm"}
    assert info(images["pgm"], :pnm) == {"image/x-portable-anymap", 130, 42, "PNMpgm"}

    assert info(images["pgm-plain"], :pnm) ==
             {"image/x-portable-anymap", 3, 11, "PNMpgm"}
  end

  test "force - pnm (ppm - pixmap) disk image (+ plain) - #seems? #type #info",
       images do
    assert seems?(images["ppm"], :pnm) == true
    assert seems?(images["ppm-plain"], :pnm) == true
    assert type(images["ppm"], :pnm) == {"image/x-portable-anymap", "PNMppm"}
    assert type(images["ppm-plain"], :pnm) == {"image/x-portable-anymap", "PNMppm"}
    assert info(images["ppm"], :pnm) == {"image/x-portable-anymap", 130, 42, "PNMppm"}

    assert info(images["ppm-plain"], :pnm) ==
             {"image/x-portable-anymap", 2, 5, "PNMppm"}
  end

  test "guess - pnm (pbm - bitmap) disk image (+ plain) - #seems? #type #info",
       images do
    assert seems?(images["pbm"]) == :pnm
    assert seems?(images["pbm-plain"]) == :pnm
    assert type(images["pbm"]) == {"image/x-portable-anymap", "PNMpbm"}
    assert type(images["pbm-plain"]) == {"image/x-portable-anymap", "PNMpbm"}
    assert info(images["pbm"]) == {"image/x-portable-anymap", 130, 42, "PNMpbm"}
    assert info(images["pbm-plain"]) == {"image/x-portable-anymap", 3, 11, "PNMpbm"}
  end

  test "guess - pnm (pgm - graymap) disk image (+ plain) - #seems? #type #info",
       images do
    assert seems?(images["pgm"]) == :pnm
    assert seems?(images["pgm-plain"]) == :pnm
    assert type(images["pgm"]) == {"image/x-portable-anymap", "PNMpgm"}
    assert type(images["pgm-plain"]) == {"image/x-portable-anymap", "PNMpgm"}
    assert info(images["pgm"]) == {"image/x-portable-anymap", 130, 42, "PNMpgm"}
    assert info(images["pgm-plain"]) == {"image/x-portable-anymap", 3, 11, "PNMpgm"}
  end

  test "guess - pnm (ppm - pixmap) disk image (+ plain) - #seems? #type #info",
       images do
    assert seems?(images["ppm"]) == :pnm
    assert seems?(images["ppm-plain"]) == :pnm
    assert type(images["ppm"]) == {"image/x-portable-anymap", "PNMppm"}
    assert type(images["ppm-plain"]) == {"image/x-portable-anymap", "PNMppm"}
    assert info(images["ppm"]) == {"image/x-portable-anymap", 130, 42, "PNMppm"}
    assert info(images["ppm-plain"]) == {"image/x-portable-anymap", 2, 5, "PNMppm"}
  end
end
