defmodule ExImageInfo.Types.JP2 do
  @moduledoc false

  @behaviour ExImageInfo.Detector
  # https://en.wikipedia.org/wiki/JPEG_2000
  # https://web.archive.org/web/20060518140251/http://www.jpeg.org/public/15444-1annexi.pdf

  @mime "image/jp2"
  @ftype "JP2"

  @signature << 0::size(24), 0x0c6A5020200D0A870A::size(72) >> #, 0::size(24), 0x14667479706A7032::size(64) >>
  @signature_ihdr << "ihdr" >>

  # Public API
  def seems?(<< @signature, _rest::binary >>), do: true
  def seems?(_), do: false

  def info(<< @signature, _::bytes-size(32), @signature_ihdr, h::size(32), w::size(32), _rest::binary >>), do: {@mime, w, h, @ftype}
  def info(_), do: nil


  def type(<< @signature, _rest::binary >>), do: {@mime, @ftype}
  def type(_), do: nil

end
