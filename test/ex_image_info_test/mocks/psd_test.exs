defmodule ExImageInfoTest.Mocks.PSDTest do
  use ExUnit.Case, async: true
  import ExImageInfo

  setup_all do
    images = %{
      "psd" => << "8BPS",
      0::size(80), # 14 - 4 = 10 * 8
      457::size(32),
      134::size(32),
      >>,
    }
    {:ok, images}
  end

  test "force - psd binary mock - #seems? #type #info", images do
    assert seems?(images["psd"], :psd) == true
    assert type(images["psd"], :psd) == {"image/psd", "PSD"}
    assert info(images["psd"], :psd) == {"image/psd", 134, 457, "PSD"}
  end
end
