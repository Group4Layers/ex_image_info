defmodule ExImageInfoTest.Mocks.ISOBMFFTest do
  @moduledoc "HEIF, HEIC and AVIF tests using binary mocks."
  use ImageTestCase

  import ExImageInfo

  alias ExImageInfoTest.Fixtures.Mocks.ISOBMFF, as: Fixtures

  setup_all do
    {:ok, Fixtures.images()}
  end

  test "force - heif/heic binary mock - #seems? #type #info (unimplemented regions)",
       images do
    # hdlr box w/o pict
    image = images["heic-hdlr-1"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # hdlr box size < 12
    image = images["heic-hdlr-2"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # ispe box w/o width and height
    image = images["heic-ispe"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # unknown box type
    image = images["heic-jxlc"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # meta size < 4
    image = images["heic-meta"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil
  end

  test "force - heif/heic binary mock - #seems? #type #info (edge cases)", images do
    # not matching primary box + extended size
    image = images["heic-extended-size-and-wrong-primary-box"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil
  end

  test "force - heif/heic/avif binary mock - #seems? #type #info", images do
    image = images["heic"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == {"image/heic", 14, 4, "HEIC"}

    image = images["heif"]
    assert seems?(image, :heif) == true
    assert type(image, :heif) == {"image/heif", "HEIF"}
    assert info(image, :heif) == {"image/heif", 13, 4, "HEIF"}

    image = images["avif"]
    assert seems?(image, :avif) == true
    assert type(image, :avif) == {"image/avif", "AVIF"}
    assert info(image, :avif) == {"image/avif", 130, 42, "AVIF"}
  end

  test "guess - heif/heic/avif binary mock - #seems? #type #info", images do
    image = images["heic"]
    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 14, 4, "HEIC"}

    image = images["heif"]
    assert seems?(image) == :heif
    assert type(image) == {"image/heif", "HEIF"}
    assert info(image) == {"image/heif", 13, 4, "HEIF"}

    image = images["avif"]
    assert seems?(image) == :avif
    assert type(image) == {"image/avif", "AVIF"}
    assert info(image) == {"image/avif", 130, 42, "AVIF"}
  end

  malformed_cases = [
    read_box_header: 270,
    ftyp: 12,
    hdlr: 60,
    ispe: 256,
    pitm: 114,
    skippable: 77
  ]

  for {location, len} <- malformed_cases do
    test "force - heif/heic binary mock - #seems? #type #info - malformed binary in #{location} when truncating 0..#{len}",
         context do
      %{"heic" => image, :test => test_name} = context

      {num, ""} =
        test_name
        |> Atom.to_string()
        |> String.split("..", trim: true)
        |> Enum.map(&String.trim(&1))
        |> List.last()
        |> Integer.parse()

      image_truncated = binary_part(image, 0, num)
      assert seems?(image_truncated) == :heic
      assert type(image_truncated) == {"image/heic", "HEIC"}
      assert info(image_truncated, :heic) == nil
    end

    test "guess - heif/heic binary mock - #seems? #type #info - malformed binary in #{location} when truncating 0..#{len}",
         context do
      %{"heic" => image, :test => test_name} = context

      {num, ""} =
        test_name
        |> Atom.to_string()
        |> String.split("..", trim: true)
        |> Enum.map(&String.trim(&1))
        |> List.last()
        |> Integer.parse()

      image_truncated = binary_part(image, 0, num)
      assert seems?(image_truncated) == :heic
      assert type(image_truncated) == {"image/heic", "HEIC"}
      assert info(image_truncated) == nil
    end
  end
end
