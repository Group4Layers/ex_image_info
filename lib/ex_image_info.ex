defmodule ExImageInfo do
  alias ExImageInfo.Types.{PNG,GIF,JPEG,BMP,TIFF,WEBP,PSD}

  @moduledoc """
  ExImageInfo is an Elixir library to parse images (binaries) and get the dimensions, detected mime-type and overall validity for a set of image formats. Main module to parse a binary and get if it seems to be an image (validity), the mime-type (and variant detected) and the dimensions of the image, based on a specific image format.

  It has convention functions to guess the type of an image
  by trying the formats supported by the library.

  ## Main features

  - Check the validity of binary by providing a specific image format*.
  - Guess the validity of an image*.
  - Get the mime-type and variant type by providing a specific format.
  - Guess the mime-type and variant type of an image.
  - Get the dimensions of an image by providing a specific format.
  - Guess the dimensions of an image.

  *Note: both cases as a general overview (partially checked).

  ## Formats

  Supported formats (image type to be parsed as):
  - `:bmp`
  - `:gif`
  - `:jpeg`
  - `:png`
  - `:psd`
  - `:tiff`
  - `:webp`

  ## Mime-types and Variants

  The image variant type is an invented string to identify the
  type of format recognized by this library (more specific than the
  mime-type).

  Each mime-type can be linked to at least one variant type:

  | mime-type    | variant type | description        |
  | ------------ | ------------ | ------------------ |
  | `image/bmp`  | `BMP`        |                    |
  | `image/gif`  | `GIF87a`     | 87a gif spec       |
  | `image/gif`  | `GIF89a`     | 89a gif spec       |
  | `image/jpeg` | `baseJPEG`   | baseline JPEG      |
  | `image/jpeg` | `progJPEG`   | progressive JPEG   |
  | `image/png`  | `PNG`        |                    |
  | `image/psd`  | `PSD`        |                    |
  | `image/tiff` | `TIFFII`     | II variant         |
  | `image/tiff` | `TIFFMM`     | MM variant         |
  | `image/webp` | `webpVP8`    | lossy              |
  | `image/webp` | `webpVP8L`   | lossless           |

  The variant type is created just to provide a bit more of information
  for every image format (if applicable).
  """

  @types [:png, :gif, :jpeg, :bmp, :tiff, :webp, :psd]

  # public API


  @doc """
  Detects if the given binary seems to be in the given image format.

  Valid [formats](#module-formats) to be used.

  Returns `true` if seems to be, `false` otherwise.

  ## Examples

  `89 50 4E 47 0D 0A 1A 0A` are the first 8 bytes in the `PNG` signature (`PNG\\r\\n0x1A\\n`).

      iex> ExImageInfo.seems? <<0x89504E470D0A1A0A::size(64)>>, :png
      true
      iex> ExImageInfo.seems? <<0x89504E470D0A1A0A::size(64)>>, :webp
      false

 `ExImageInfo.seems?/2` and `ExImageInfo.seems?/1` does not necessarily needs a real image (as it is shown in the previous example) because it just checks the signature of every file format.

  Usually it is used as:

      ExImageInfo.seems? File.read!("path/to/image.gif"), :gif
      # true

      maybe_png_binary |> ExImageInfo.seems? :png
      # false
  """
  @spec seems?(binary, format :: atom) :: boolean | nil
  def seems?(binary, format)
  def seems?(binary, :png), do: PNG.seems?(binary)
  def seems?(binary, :gif), do: GIF.seems?(binary)
  def seems?(binary, :jpeg), do: JPEG.seems?(binary)
  def seems?(binary, :bmp), do: BMP.seems?(binary)
  def seems?(binary, :tiff), do: TIFF.seems?(binary)
  def seems?(binary, :webp), do: WEBP.seems?(binary)
  def seems?(binary, :psd), do: PSD.seems?(binary)
  # def seems?(binary, :svg), do: SVG.seems?(binary)
  def seems?(_, _), do: nil

  @doc """
  Detects the image format that seems to be the given binary (*guessed* version of `ExImageInfo.seems?/2`).

  Returns the atom (valid [formats](#module-formats)) if it matches, `nil` otherwise.

  ## Examples

  `38 42 50 53` are the first 4 bytes in the `PSD` signature (`8BPS`).

      iex> ExImageInfo.seems? <<0x38425053::size(32)>>
      :psd
      iex> ExImageInfo.seems? <<0x384250::size(24)>>
      nil

  `ExImageInfo.seems?/2` and `ExImageInfo.seems?/1` does not necessarily needs a real image (as it is shown in the previous example) because it just checks the signature of every file format.

  Usually it is used as:

      ExImageInfo.seems? File.read!("path/to/image.unknown")
      # :tiff

      webp_full_binary |> ExImageInfo.seems?
      # :webp
  """
  @spec seems?(binary) :: atom | nil
  def seems?(binary), do: try_seems?(binary, @types)

  @doc """
  Gets the mime-type and variant type for the given image format and binary.

  Possible [Mime-types and Variants](#module-mime-types-and-variants) to be returned.

  Valid [formats](#module-formats) to be used.

  Returns a 2-item tuple with the mime-type and the variant type when the binary matches, `nil` otherwise.

  ## Examples

  `89 50 4E 47 0D 0A 1A 0A` are the first 8 bytes in the `PNG` signature (`PNG\\r\\n0x1A\\n`).

      iex> ExImageInfo.type <<0x89504E470D0A1A0A::size(64)>>, :png
      nil
      iex> ExImageInfo.type <<"RIFF", 0::size(32), "WEBPVP8L", 0::size(32), 0x2F7AC07100358683B68D::size(80)>>, :webp
      {"image/webp", "webpVP8L"}

  The signature part of a png it is now enough to get the type (it check also the IHDR field, just before the width and height).

  Usually it is used as:

      ExImageInfo.type File.read!("path/to/image.gif"), :gif
      # {"image/gif", "GIF87a"}

      maybe_png_binary |> ExImageInfo.type :png
      # nil
  """
  @spec type(binary, format :: atom) :: {mimetype :: String.t, variant :: String.t} | nil
  def type(binary, format)
  def type(binary, :png), do: PNG.type(binary)
  def type(binary, :gif), do: GIF.type(binary)
  def type(binary, :jpeg), do: JPEG.type(binary)
  def type(binary, :bmp), do: BMP.type(binary)
  def type(binary, :tiff), do: TIFF.type(binary)
  def type(binary, :webp), do: WEBP.type(binary)
  def type(binary, :psd), do: PSD.type(binary)
  # def type(binary, :svg, binary), do: SVG.type(binary)
  def type(_, _), do: nil

  @doc """
  Gets the mime-type and variant type for the given image binary (*guessed* version of `ExImageInfo.type/2`).

  Possible [Mime-types and Variants](#module-mime-types-and-variants) to be returned.

  Returns a 2-item tuple with the mime-type and the variant type when the binary matches, `nil` otherwise.

  ## Examples

      iex> ExImageInfo.type <<0x38425053::size(32)>>
      {"image/psd", "PSD"}
      iex> ExImageInfo.type <<0x384250::size(24)>>
      nil

  Usually it is used as:

      ExImageInfo.type File.read!("path/to/image.unknown")
      # {"image/tiff", "TIFFMM"}

      webp_full_binary |> ExImageInfo.type
      # {"image/webp", "webpVP8"}
  """
  @spec type(binary) :: {mimetype :: String.t, variant :: String.t} | nil
  def type(binary), do: try_type(binary, @types)

  @doc """
  Gets the mime-type, variant-type and dimensions (width, height) for the given image format and binary.

  Possible [Mime-types and Variants](#module-mime-types-and-variants) to be returned.

  Valid [formats](#module-formats) to be used.

  Returns a 4-item tuple with the mime-type, width, height and the variant type when the binary matches, `nil` otherwise.

  ## Examples

  `89 50 4E 47 0D 0A 1A 0A` are the first 8 bytes in the `PNG` signature (`PNG\\r\\n0x1A\\n`).

      iex> ExImageInfo.info <<0x89504E470D0A1A0A::size(64)>>, :png
      nil
      iex> ExImageInfo.info <<"RIFF", 0::size(32), "WEBPVP8L", 0::size(32), 0x2F7AC07100358683B68D::size(80)>>, :webp
      {"image/webp", 123, 456, "webpVP8L"}

  The signature part of a png it is now enough to get the type (it check also the IHDR field, just before the width and height).

  Usually it is used as:

      ExImageInfo.info File.read!("path/to/image.gif"), :gif
      # {"image/gif", 1920, 1080, "GIF87a"}

      maybe_png_binary |> ExImageInfo.info :png
      # nil
  """
  @spec info(binary, format :: atom) :: {mimetype :: String.t, width :: Integer.t, height :: Integer.t, variant :: String.t} | nil
  def info(binary, format)
  def info(binary, :png), do: PNG.info(binary)
  def info(binary, :gif), do: GIF.info(binary)
  def info(binary, :jpeg), do: JPEG.info(binary)
  def info(binary, :bmp), do: BMP.info(binary)
  def info(binary, :tiff), do: TIFF.info(binary)
  def info(binary, :webp), do: WEBP.info(binary)
  def info(binary, :psd), do: PSD.info(binary)
  # def info(binary, :svg), do: SVG.info(binary)
  def info(_, _), do: nil

  @doc """
  Gets the mime-type, variant-type and dimensions (width, height) for the given image binary (*guessed* version of `ExImageInfo.info/2`).

  Possible [Mime-types and Variants](#module-mime-types-and-variants) to be returned.

  Returns a 4-item tuple with the mime-type, width, height and the variant type when the binary matches, `nil` otherwise.

  ## Examples

      iex> ExImageInfo.info <<0x38425053::size(32)>>
      nil
      iex> ExImageInfo.info <<0x38425053::size(32), 0::size(80), 10::size(32), 12::size(32)>>
      {"image/psd", 12, 10, "PSD"}

  Usually it is used as:

      ExImageInfo.info File.read!("path/to/image.unknown")
      # {"image/tiff", 128, 256, "TIFFMM"}

      webp_full_binary |> ExImageInfo.info
      # {"image/webp", 20, 100, "webpVP8"}
  """
  @spec info(binary) :: {mimetype :: String.t, width :: Integer.t, height :: Integer.t, variant :: String.t} | nil
  def info(binary), do: try_info(binary, @types)



  # private

  defp try_seems?(_binary, []), do: nil
  defp try_seems?(binary, [type | types]) do
    cond do
      seems?(binary, type) -> type
      true -> try_seems?(binary, types)
    end
  end

  defp try_type(_binary, []), do: nil
  defp try_type(binary, [type | types]) do
    case type(binary, type) do
      type_t when is_tuple(type_t) -> type_t
      _ -> try_type(binary, types)
    end
  end

  defp try_info(_binary, []), do: nil
  defp try_info(binary, [type | types]) do
    case info(binary, type) do
      info_t when is_tuple(info_t) -> info_t
      _ -> try_info(binary, types)
    end
  end

end
