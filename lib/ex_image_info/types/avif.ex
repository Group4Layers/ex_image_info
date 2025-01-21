defmodule ExImageInfo.Types.AVIF do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  alias ExImageInfo.Types.HEIF

  @mime "image/avif"
  @signature <<"ftypavif">>
  @ftype "AVIF"

  ## Public API

  def seems?(<<_::size(32), @signature, _rest::binary>>), do: true
  def seems?(_), do: false

  def info(<<_::size(32), @signature, rest::binary>>),
    do: HEIF.info(rest, @mime, @ftype)

  def info(_), do: nil

  def type(<<_::size(32), @signature, _rest::binary>>), do: {@mime, @ftype}
  def type(_), do: nil
end
