defmodule ExImageInfoTest.Mocks.PNMTest do
  use ExUnit.Case, async: true

  import ExImageInfo

  setup_all do
    images = %{
      "pbm" => <<
        "P4",
        0x0A,
        # width
        "134",
        0x20,
        # height
        "457",
        0x0A,
        0x00
      >>,
      "pgm" => <<
        "P5",
        0x0A,
        # width
        "134",
        0x20,
        # height
        "457",
        0x0A,
        0x00
      >>,
      "ppm" => <<
        "P6",
        0x0A,
        # width
        "134",
        0x20,
        # height
        "457",
        0x0A,
        0x00
      >>,
      "pbm-plain" => """
      P1 # comment
      134 457
      0 1 0 1 0 0 1
      0 1 1 1 1 0 0
      """,
      "pgm-plain" => """
      P2
      # comments
       # more comments + space
      134 # alone
        457 # other line + space
      5
      0 2 3 4 0 5 1
      0 2 3 0 0 1 2
      """,
      "ppm-plain" => """
      P3
        134# comments
         # more comments
       457 5 0 2 3
      """,
      "ppm-wrong" => """
      P
        134# comments
         # more comments
       457 5 0 2 3
      """
    }

    {:ok, images}
  end

  test "force - pnm (pbm - bitmap) binary and plain mock - #seems? #type #info",
       images do
    assert seems?(images["pbm"], :pnm) == true
    assert seems?(images["pbm-plain"], :pnm) == true
    assert type(images["pbm"], :pnm) == {"image/x-portable-anymap", "PNMpbm"}
    assert type(images["pbm-plain"], :pnm) == {"image/x-portable-anymap", "PNMpbm"}
    assert info(images["pbm"], :pnm) == {"image/x-portable-anymap", 134, 457, "PNMpbm"}

    assert info(images["pbm-plain"], :pnm) ==
             {"image/x-portable-anymap", 134, 457, "PNMpbm"}
  end

  test "force - pnm (pgm - graymap) binary and plain mock - #seems? #type #info",
       images do
    assert seems?(images["pgm"], :pnm) == true
    assert seems?(images["pgm-plain"], :pnm) == true
    assert type(images["pgm"], :pnm) == {"image/x-portable-anymap", "PNMpgm"}
    assert type(images["pgm-plain"], :pnm) == {"image/x-portable-anymap", "PNMpgm"}
    assert info(images["pgm"], :pnm) == {"image/x-portable-anymap", 134, 457, "PNMpgm"}

    assert info(images["pgm-plain"], :pnm) ==
             {"image/x-portable-anymap", 134, 457, "PNMpgm"}
  end

  test "force - pnm (ppm - pixmap) binary and plain mock - #seems? #type #info",
       images do
    assert seems?(images["ppm"], :pnm) == true
    assert seems?(images["ppm-plain"], :pnm) == true
    assert type(images["ppm"], :pnm) == {"image/x-portable-anymap", "PNMppm"}
    assert type(images["ppm-plain"], :pnm) == {"image/x-portable-anymap", "PNMppm"}
    assert info(images["ppm"], :pnm) == {"image/x-portable-anymap", 134, 457, "PNMppm"}

    assert info(images["ppm-plain"], :pnm) ==
             {"image/x-portable-anymap", 134, 457, "PNMppm"}
  end

  test "guess - pnm (pbm - bitmap) binary and plain mock - #seems? #type #info",
       images do
    assert seems?(images["pbm"]) == :pnm
    assert seems?(images["pbm-plain"]) == :pnm
    assert type(images["pbm"]) == {"image/x-portable-anymap", "PNMpbm"}
    assert type(images["pbm-plain"]) == {"image/x-portable-anymap", "PNMpbm"}
    assert info(images["pbm"]) == {"image/x-portable-anymap", 134, 457, "PNMpbm"}
    assert info(images["pbm-plain"]) == {"image/x-portable-anymap", 134, 457, "PNMpbm"}
  end

  test "guess - pnm (pgm - graymap) binary and plain mock - #seems? #type #info",
       images do
    assert seems?(images["pgm"]) == :pnm
    assert seems?(images["pgm-plain"]) == :pnm
    assert type(images["pgm"]) == {"image/x-portable-anymap", "PNMpgm"}
    assert type(images["pgm-plain"]) == {"image/x-portable-anymap", "PNMpgm"}
    assert info(images["pgm"]) == {"image/x-portable-anymap", 134, 457, "PNMpgm"}
    assert info(images["pgm-plain"]) == {"image/x-portable-anymap", 134, 457, "PNMpgm"}
  end

  test "guess - pnm (ppm - pixmap) binary and plain mock - #seems? #type #info",
       images do
    assert seems?(images["ppm"]) == :pnm
    assert seems?(images["ppm-plain"]) == :pnm
    assert type(images["ppm"]) == {"image/x-portable-anymap", "PNMppm"}
    assert type(images["ppm-plain"]) == {"image/x-portable-anymap", "PNMppm"}
    assert info(images["ppm"]) == {"image/x-portable-anymap", 134, 457, "PNMppm"}
    assert info(images["ppm-plain"]) == {"image/x-portable-anymap", 134, 457, "PNMppm"}
  end

  test "ppm wrong plain mock (force and guess) - #seems? #type #info",
       images do
    assert seems?(images["ppm-wrong"], :pnm) == false
    assert type(images["ppm-wrong"], :pnm) == nil
    assert info(images["ppm-wrong"], :pnm) == nil

    assert seems?(images["ppm-wrong"]) == nil
    assert type(images["ppm-wrong"]) == nil
    assert info(images["ppm-wrong"]) == nil
  end
end
