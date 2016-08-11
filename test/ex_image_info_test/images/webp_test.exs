defmodule ExImageInfoTest.Images.WEBPTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "webpVP8" => TestHelper.read_image("valid/webp/layers-lossy.webp"),
      "webpVP8L" => TestHelper.read_image("valid/webp/layers-lossless.webp"),
    }
    {:ok, images}
  end

  @tag :wip
  test "force - webp disk image (lossy) - #seems? #type #info", images do
    assert seems?(images["webpVP8"], :webp) == true
    assert type(images["webpVP8"], :webp) == {"image/webp", "webpVP8"}
    assert info(images["webpVP8"], :webp) == {"image/webp", 130, 42, "webpVP8"}
  end

  @tag :wip
  test "force - webp disk image (lossless) - #seems? #type #info", images do
    assert seems?(images["webpVP8L"], :webp) == true
    assert type(images["webpVP8L"], :webp) == {"image/webp", "webpVP8L"}
    assert info(images["webpVP8L"], :webp) == {"image/webp", 130, 42, "webpVP8L"}
  end
end
