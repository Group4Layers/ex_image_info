defmodule ExImageInfo.Types.PSD do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  @mime "image/psd"
  @ftype "PSD"

  @signature <<"8BPS">>

  def seems?(<< @signature, _::binary >>), do: true
  def seems?(_), do: false

  def info(<< @signature, _skip::bytes-size(10), height::size(32), width::size(32), _::binary >>), do: {@mime, width, height, @ftype}
  def info(_), do: nil

  def type(<< @signature, _::binary >>), do: {@mime, @ftype}
  def type(_), do: nil

end
