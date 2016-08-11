defmodule ExImageInfo.Types.GIF do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  @mime "image/gif"
  @ftype89 "GIF89a"
  @ftype87 "GIF87a"

  @signature_87a <<"GIF87a">>
  @signature_89a <<"GIF89a">>

  def seems?(<< @signature_87a, rest::binary >>), do: true
  def seems?(<< @signature_89a, rest::binary >>), do: true
  def seems?(_), do: false

  def info(<< @signature_87a, width::little-size(16), height::little-size(16), _rest::binary >>), do: {@mime, width, height, @ftype87}
  def info(<< @signature_89a, width::little-size(16), height::little-size(16), _rest::binary >>), do: {@mime, width, height, @ftype89}
  def info(_), do: nil

  def type(<< @signature_89a, _rest::binary >>), do: {@mime, @ftype89}
  def type(<< @signature_87a, _rest::binary >>), do: {@mime, @ftype87}
  def type(_), do: nil

end
