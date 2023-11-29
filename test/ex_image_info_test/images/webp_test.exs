defmodule ExImageInfoTest.Images.WEBPTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      # Comments: GIMP options to export the original images
      "webpVP8" => TestHelper.read_image("valid/webp/layers-lossy.webp"),
      "webpVP8L" => TestHelper.read_image("valid/webp/layers-lossless.webp"),
      "webpVP8X" => TestHelper.read_image("valid/webp/layers-anim.webp"),
    }
    {:ok, images}
  end

  test "force - webp disk image (lossy) - #seems? #type #info", images do
    assert seems?(images["webpVP8"], :webp) == true
    assert type(images["webpVP8"], :webp) == {"image/webp", "webpVP8"}
    assert info(images["webpVP8"], :webp) == {"image/webp", 130, 42, "webpVP8"}
  end

  test "force - webp disk image (lossless) - #seems? #type #info", images do
    assert seems?(images["webpVP8L"], :webp) == true
    assert type(images["webpVP8L"], :webp) == {"image/webp", "webpVP8L"}
    assert info(images["webpVP8L"], :webp) == {"image/webp", 130, 42, "webpVP8L"}
  end

  test "force - webp disk image (anim) - #seems? #type #info", images do
    assert seems?(images["webpVP8X"], :webp) == true
    assert type(images["webpVP8X"], :webp) == {"image/webp", "webpVP8X"}
    assert info(images["webpVP8X"], :webp) == {"image/webp", 130, 42, "webpVP8X"}
  end
end
