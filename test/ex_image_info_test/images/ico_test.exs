defmodule ExImageInfoTest.Images.ICOTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "ico" => TestHelper.read_image("valid/ico/wikipedia.ico"),
      "ico-256" => TestHelper.read_image("valid/ico/w.ico")
    }

    {:ok, images}
  end

  test "force - ico disk image - #seems? #type #info", images do
    assert seems?(images["ico"], :ico) == true
    assert seems?(images["ico-256"], :ico) == true
    assert type(images["ico"], :ico) == {"image/x-icon", "ICO"}
    assert type(images["ico-256"], :ico) == {"image/x-icon", "ICO"}
    assert info(images["ico"], :ico) == {"image/x-icon", 48, 48, "ICO"}
    assert info(images["ico-256"], :ico) == {"image/x-icon", 256, 256, "ICO"}
  end

  test "guess - ico disk image - #seems? #type #info", images do
    assert seems?(images["ico"]) == :ico
    assert seems?(images["ico-256"]) == :ico
    assert type(images["ico"]) == {"image/x-icon", "ICO"}
    assert type(images["ico-256"]) == {"image/x-icon", "ICO"}
    assert info(images["ico"]) == {"image/x-icon", 48, 48, "ICO"}
    assert info(images["ico-256"]) == {"image/x-icon", 256, 256, "ICO"}
  end
end
