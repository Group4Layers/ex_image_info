defmodule ExImageInfoTest.Images.ISOBMFFTest do
  @moduledoc "HEIF, HEIC and AVIF tests using image files"
  use ExUnit.Case, async: true

  import ExImageInfo

  setup_all do
    images = %{
      "heic" => TestHelper.read_image("valid/isobmff/layers.heic"),
      "heif" => TestHelper.read_image("valid/isobmff/layers.heif"),
      "heic-min" => TestHelper.read_image("valid/isobmff/layers-min.heic"),
      "heic-rotated" => TestHelper.read_image("valid/isobmff/layers-rotated.heic"),
      "avif" => TestHelper.read_image("valid/isobmff/layers.avif")
    }

    {:ok, images}
  end

  @tag :fetch_external
  @tag :tmp_dir
  test "guess - isobmff (heif/heic) external images fetched (sequences) - #seems? #type #info",
       %{tmp_dir: tmp_dir} do
    base_url =
      "https://github.com/sunsided/heic-conversion-service/raw/refs/heads/main/data/nokia/"

    image = "image_sequences/bird_burst.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif-sequence", "HEIFS"}
    assert info(image) == {"image/heif-sequence", 1280, 720, "HEIFS"}

    image = "image_sequences/candle_animation.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif-sequence", "HEIFS"}
    assert info(image) == {"image/heif-sequence", 256, 144, "HEIFS"}

    image = "image_sequences/rally_burst.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif-sequence", "HEIFS"}
    assert info(image) == {"image/heif-sequence", 1280, 720, "HEIFS"}

    image = "image_sequences/sea1_animation.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif-sequence", "HEIFS"}
    assert info(image) == {"image/heif-sequence", 256, 144, "HEIFS"}

    image = "image_sequences/starfield_animation.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif-sequence", "HEIFS"}
    assert info(image) == {"image/heif-sequence", 256, 144, "HEIFS"}
  end

  @tag :fetch_external
  @tag :tmp_dir
  test "guess - isobmff (heif/heic) external images fetched - #seems? #type #info", %{
    tmp_dir: tmp_dir
  } do
    base_url =
      "https://github.com/sdsykes/fastimage/raw/refs/heads/master/test/fixtures/"

    image = "heic/heic-single.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif", "HEIF"}
    assert info(image) == {"image/heif", 1440, 960, "HEIF"}

    image = "heic/heic-empty.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 3992, 2992, "HEIC"}

    image = "heic/heic-iphone.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    # irot:
    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 4032, 3024, "HEIC"}

    image = "heic/heic-iphone7.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    # irot:
    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 4032, 3024, "HEIC"}

    image = "heic/test.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 700, 476, "HEIC"}

    image = "heic/test-meta-after-mdat.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 4000, 3000, "HEIC"}

    image = "heic/heic-maybebroken.HEIC"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 4032, 3024, "HEIC"}

    image = "heic/heic-collection.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif", "HEIF"}
    assert info(image) == {"image/heif", 1440, 960, "HEIF"}

    image = "heic/inverted.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 3024, 4032, "HEIC"}

    base_url =
      "https://github.com/sunsided/heic-conversion-service/raw/refs/heads/main/data/nokia/"

    image = "heifv2/stereo_1200x800.heic"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :heif
    assert type(image) == {"image/heif", "HEIF"}
    assert info(image) == {"image/heif", 1200, 800, "HEIF"}
  end

  @tag :fetch_external
  @tag :tmp_dir
  test "guess - isobmff (avif) external images fetched - #seems? #type #info", %{
    tmp_dir: tmp_dir
  } do
    base_url =
      "https://github.com/sdsykes/fastimage/raw/refs/heads/master/test/fixtures/"

    image = "avif/fox.avif"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :avif
    assert type(image) == {"image/avif", "AVIF"}
    assert info(image) == {"image/avif", 1204, 799, "AVIF"}

    image = "avif/hato.avif"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :avif
    assert type(image) == {"image/avif", "AVIF"}
    assert info(image) == {"image/avif", 3082, 2048, "AVIF"}

    image = "avif/kimono.avif"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :avif
    assert type(image) == {"image/avif", "AVIF"}
    assert info(image) == {"image/avif", 722, 1024, "AVIF"}

    image = "avif/red_green_flash.avif"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :avif
    assert type(image) == {"image/avif-sequence", "AVIFS"}
    assert info(image) == {"image/avif-sequence", 256, 256, "AVIFS"}

    image = "avif/star.avifs"
    image = fetch_binary(base_url <> image, tmp_dir)

    assert seems?(image) == :avif
    assert type(image) == {"image/avif-sequence", "AVIFS"}
    assert info(image) == {"image/avif-sequence", 159, 159, "AVIFS"}
  end

  test "force - isobmff disk image - #seems? #type #info", images do
    image = images["heic"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == {"image/heic", 130, 64, "HEIC"}

    image = images["heic-min"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == {"image/heic", 14, 4, "HEIC"}

    image = images["heif"]
    assert seems?(image, :heif) == true
    assert type(image, :heif) == {"image/heif", "HEIF"}
    assert info(image, :heif) == {"image/heif", 130, 42, "HEIF"}

    image = images["heic-rotated"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == {"image/heic", 42, 130, "HEIC"}

    image = images["avif"]
    assert seems?(image, :avif) == true
    assert type(image, :avif) == {"image/avif", "AVIF"}
    assert info(image, :avif) == {"image/avif", 130, 42, "AVIF"}
  end

  test "guess - heic disk image - #seems? #type #info", images do
    image = images["heic"]
    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 130, 64, "HEIC"}

    image = images["heic-min"]
    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 14, 4, "HEIC"}

    image = images["heif"]
    assert seems?(image) == :heif
    assert type(image) == {"image/heif", "HEIF"}
    assert info(image) == {"image/heif", 130, 42, "HEIF"}

    image = images["heic-rotated"]
    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 42, 130, "HEIC"}

    image = images["avif"]
    assert seems?(image) == :avif
    assert type(image) == {"image/avif", "AVIF"}
    assert info(image) == {"image/avif", 130, 42, "AVIF"}
  end

  defp fetch_binary(url, tmp_dir, debug? \\ false) do
    true = Enum.all?([:inets, :ssl], &Application.ensure_started/1)

    filename = Path.basename(url)
    tmp_file = Path.join([tmp_dir, filename])

    if debug?, do: IO.puts("Downloading #{url} to #{tmp_file}")

    case :httpc.request(:get, {~c(#{url}), []}, [timeout: 10_000],
           stream: ~c(#{tmp_file})
         ) do
      {:ok, :saved_to_file} -> File.read!(tmp_file)
      {:error, reason} -> raise "Failed to download #{url}: #{inspect(reason)}"
      other -> raise "Failed to download #{url}: #{inspect(other)}"
    end
  end
end
