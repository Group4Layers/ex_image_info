defmodule ExImageInfo.Types.BMP do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  @mime "image/bmp"
  @ftype "BMP"

  @signature <<"BM">>

  def seems?(<<@signature, _rest::binary>>), do: true
  def seems?(_), do: false

  def info(
        <<@signature, _::bytes-size(16), width::little-size(16), _::bytes-size(2),
          height::little-size(16), _rest::binary>>
      ),
      do: {@mime, width, height, @ftype}

  def info(_), do: nil

  def type(<<@signature, _rest::binary>>), do: {@mime, @ftype}
  def type(_), do: nil
end
