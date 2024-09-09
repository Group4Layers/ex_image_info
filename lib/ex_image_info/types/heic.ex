defmodule ExImageInfo.Types.HEIC do
  @moduledoc false

  alias ExImageInfo.Types.HEIF

  @behaviour ExImageInfo.Detector

  @mime_heic "image/heic"
  @mime_heic_sequence "image/heic-sequence"
  @signature_heic <<"ftypheic">>
  @signature_heim <<"ftypheim">>
  @signature_heis <<"ftypheis">>
  @signature_heix <<"ftypheix">>
  @signature_hevc <<"ftyphevc">>
  @signature_hevm <<"ftyphevm">>
  @signature_hevs <<"ftyphevs">>
  @signature_hevx <<"ftyphevx">>
  @ftype_heic "HEIC"
  @ftype_heic_sequence "HEICS"

  ## Public API

  def seems?(<<_::size(32), @signature_heic, _rest::binary>>), do: true
  def seems?(<<_::size(32), @signature_heim, _rest::binary>>), do: true
  def seems?(<<_::size(32), @signature_heis, _rest::binary>>), do: true
  def seems?(<<_::size(32), @signature_heix, _rest::binary>>), do: true
  def seems?(_), do: false

  def info(<<_::size(32), @signature_heic, rest::binary>>),
    do: HEIF.info(rest, @mime_heic, @ftype_heic)

  def info(<<_::size(32), @signature_heim, rest::binary>>),
    do: HEIF.info(rest, @mime_heic, @ftype_heic)

  def info(<<_::size(32), @signature_heis, rest::binary>>),
    do: HEIF.info(rest, @mime_heic, @ftype_heic)

  def info(<<_::size(32), @signature_heix, rest::binary>>),
    do: HEIF.info(rest, @mime_heic, @ftype_heic)

  def info(<<_::size(32), @signature_hevc, rest::binary>>),
    do: HEIF.info(rest, @mime_heic_sequence, @ftype_heic_sequence)

  def info(<<_::size(32), @signature_hevm, rest::binary>>),
    do: HEIF.info(rest, @mime_heic_sequence, @ftype_heic_sequence)

  def info(<<_::size(32), @signature_hevs, rest::binary>>),
    do: HEIF.info(rest, @mime_heic_sequence, @ftype_heic_sequence)

  def info(<<_::size(32), @signature_hevx, rest::binary>>),
    do: HEIF.info(rest, @mime_heic_sequence, @ftype_heic_sequence)

  def info(_), do: nil

  def type(<<_::size(32), @signature_heic, _rest::binary>>),
    do: {@mime_heic, @ftype_heic}

  def type(<<_::size(32), @signature_heim, _rest::binary>>),
    do: {@mime_heic, @ftype_heic}

  def type(<<_::size(32), @signature_heis, _rest::binary>>),
    do: {@mime_heic, @ftype_heic}

  def type(<<_::size(32), @signature_heix, _rest::binary>>),
    do: {@mime_heic, @ftype_heic}

  def type(<<_::size(32), @signature_hevc, _rest::binary>>),
    do: {@mime_heic_sequence, @ftype_heic_sequence}

  def type(<<_::size(32), @signature_hevm, _rest::binary>>),
    do: {@mime_heic_sequence, @ftype_heic_sequence}

  def type(<<_::size(32), @signature_hevs, _rest::binary>>),
    do: {@mime_heic_sequence, @ftype_heic_sequence}

  def type(<<_::size(32), @signature_hevx, _rest::binary>>),
    do: {@mime_heic_sequence, @ftype_heic_sequence}

  def type(_), do: nil
end
