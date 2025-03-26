defmodule ExImageInfo.Types.HEIF do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  alias ExImageInfo.Types.ISOBMFF

  @signature_base "ftyp"

  @mime "image/heif"
  @ftype "HEIF"
  @brand "mif1"

  @mime_seq "image/heif-sequence"
  @ftype_seq "HEIFS"
  @brand_seq "msf1"

  ## Public API

  def seems?(<<_::size(32), @signature_base, @brand, _::binary>>), do: true
  def seems?(<<_::size(32), @signature_base, @brand_seq, _::binary>>), do: true
  def seems?(_), do: false

  def info(<<_::size(32), @signature_base, @brand, _::binary>> = binary) do
    with {w, h} <- ISOBMFF.parse_image_size(binary) do
      {@mime, w, h, @ftype}
    end
  end

  def info(<<_::size(32), @signature_base, @brand_seq, _::binary>> = binary) do
    with {w, h} <- ISOBMFF.parse_image_size(binary) do
      {@mime_seq, w, h, @ftype_seq}
    end
  end

  def info(_), do: nil

  def type(<<_::size(32), @signature_base, @brand, _::binary>>), do: {@mime, @ftype}

  def type(<<_::size(32), @signature_base, @brand_seq, _::binary>>),
    do: {@mime_seq, @ftype_seq}

  def type(_), do: nil
end
