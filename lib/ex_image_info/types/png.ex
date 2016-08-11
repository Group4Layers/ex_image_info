defmodule ExImageInfo.Types.PNG do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  @mime "image/png"
  @ftype "PNG"

  @signature <<"PNG\r\n", 0x1A, "\n">>
  @signature_ihdr <<"IHDR">>

  def seems?(<< _::bytes-size(1), @signature, _rest::binary >>), do: true
  def seems?(_), do: false

  def info(<< _::bytes-size(1), @signature, _::size(32), @signature_ihdr, width::size(32), height::size(32), _rest::binary >>), do: {@mime, width, height, @ftype}
  def info(_), do: nil

  def type(<< _::size(8), @signature, _::size(32), @signature_ihdr, _rest::binary >>), do: {@mime, @ftype}
  def type(_), do: nil

end
