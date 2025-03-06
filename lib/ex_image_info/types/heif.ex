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
        |> Enum.map(fn <<_::size(32), width::size(32), height::size(32), rest::binary>> ->
          [_ispe | clap] = String.split(rest, "clap")

          if length(clap) > 0 do
            <<clap_width_n::size(32), clap_width_d::size(32), clap_height_n::size(32),
              clap_height_d::size(32), _horizontal_offset_n::size(32),
              _horizontal_offset_d::size(32), _vertical_offset_n::size(32),
              _vertical_offset_d::size(32), _rest::binary>> = List.first(clap)

            clap_width = round(clap_width_n / clap_width_d)
            clap_height = round(clap_height_n / clap_height_d)
            {clap_width, clap_height}
          else
            {width, height}
          end
        end)
        |> Enum.max_by(&elem(&1, 0))

      {width, height}
    end
  end
end
