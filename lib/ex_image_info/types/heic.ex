defmodule ExImageInfo.Types.HEIC do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  alias ExImageInfo.Types.ISOBMFF

  @signature_base "ftyp"

  @mime "image/heic"
  @ftype "HEIC"
  @brands ["heic", "heix", "heim", "heis"]

  @mime_seq "image/heic-sequence"
  @ftype_seq "HEICS"
  @brands_seq ["hevc", "hevx", "hevm", "hevs"]

  ## Public API

  def seems?(<<_::size(32), @signature_base, brand::binary-size(4), _::binary>>)
      when brand in @brands,
      do: true

  def seems?(<<_::size(32), @signature_base, brand_seq::binary-size(4), _::binary>>)
      when brand_seq in @brands_seq,
      do: true

  def seems?(_), do: false

  def info(<<_::size(32), @signature_base, brand::binary-size(4), _::binary>> = binary)
      when brand in @brands do
    with {w, h} <- ISOBMFF.parse_image_size(binary) do
      {@mime, w, h, @ftype}
    end
  end

  def info(
        <<_::size(32), @signature_base, brand_seq::binary-size(4), _::binary>> = binary
      )
      when brand_seq in @brands_seq do
    with {w, h} <- ISOBMFF.parse_image_size(binary) do
      {@mime_seq, w, h, @ftype_seq}
    end
  end

  def info(_), do: nil

  def type(<<_::size(32), @signature_base, brand::binary-size(4), _::binary>>)
      when brand in @brands,
      do: {@mime, @ftype}

  def type(<<_::size(32), @signature_base, brand_seq::binary-size(4), _::binary>>)
      when brand_seq in @brands_seq,
      do: {@mime_seq, @ftype_seq}

  def type(_), do: nil
end
