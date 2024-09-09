defmodule ExImageInfo.Types.HEIF do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  @mime_heif "image/heif"
  @mime_heif_sequence "image/heif-sequence"
  @signature_mif1 <<"ftypmif1">>
  @signature_msf1 <<"ftypmsf1">>
  @ftype_heif "HEIF"
  @ftype_heif_sequence "HEIFS"

  ## Public API

  def seems?(<<_::size(32), @signature_mif1, _rest::binary>>), do: true
  def seems?(<<_::size(32), @signature_msf1, _rest::binary>>), do: true
  def seems?(_), do: false

  def info(<<_::size(32), @signature_mif1, rest::binary>>) do
    info(rest, @mime_heif, @ftype_heif)
  end

  def info(<<_::size(32), @signature_msf1, rest::binary>>),
    do: info(rest, @mime_heif_sequence, @ftype_heif_sequence)

  def info(_), do: nil

  def info(binary, mime, ftype) do
    case size(binary) do
      {w, h} -> {mime, w, h, ftype}
      _ -> nil
    end
  end

  def type(<<_::size(32), @signature_mif1, _rest::binary>>),
    do: {@mime_heif, @ftype_heif}

  def type(<<_::size(32), @signature_msf1, _rest::binary>>),
    do: {@mime_heif_sequence, @ftype_heif_sequence}

  def type(_), do: nil

  defp size(binary) do
    [_hd | ispe_boxes] = String.split(binary, "ispe")

    if length(ispe_boxes) > 0 do
      {width, height} =
        ispe_boxes
        |> Enum.map(fn <<_::size(32), width::size(32), height::size(32), _rest::binary>> ->
          {width, height}
        end)
        |> Enum.max_by(&elem(&1, 0))

      {width, height}
    else
      nil
    end
  end
end
