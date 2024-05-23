defmodule ExImageInfo.Types.WEBP do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  require Bitwise

  @mime "image/webp"
  @ftype_vp8 "webpVP8"
  @ftype_vp8l "webpVP8L"
  @ftype_vp8x "webpVP8X"

  @signature_riff <<"RIFF">>
  @signature_webp <<"WEBP">>
  @signature_vp8 <<"VP8">>

  ## Public API

  def seems?(
        <<@signature_riff, _skip::bytes-size(4), @signature_webp, @signature_vp8,
          _rest::binary>>
      ),
      do: true

  def seems?(_), do: false

  def info(
        <<@signature_riff, _skip::bytes-size(4), @signature_webp, @signature_vp8,
          lossy::bytes-size(1), _skip2::bytes-size(4), first::bytes-size(1),
          next::bytes-size(9), _rest::binary>>
      ) do
    <<_skip::bytes-size(2), sign::bytes-size(3), _::binary>> = next

    cond do
      lossy == " " and first != 0x2F -> parse_lossy(first, next)
      lossy == "L" and sign != <<0x9D012A::size(24)>> -> parse_lossless(first, next)
      lossy == "X" -> parse_vp8xbitstream(next)
      true -> nil
    end
  end

  def info(_), do: nil

  def type(
        <<@signature_riff, _skip::bytes-size(4), @signature_webp, @signature_vp8,
          lossy::bytes-size(1), _rest::binary>>
      ) do
    cond do
      lossy == " " -> {@mime, @ftype_vp8}
      lossy == "L" -> {@mime, @ftype_vp8l}
      lossy == "X" -> {@mime, @ftype_vp8x}
      true -> nil
    end
  end

  def type(_), do: nil

  ## Private

  defp parse_lossy(
         _first,
         <<_skip::bytes-size(5), w::little-size(16), h::little-size(16), _rest::binary>>
       ) do
    {@mime, Bitwise.band(w, 0x3FFF), Bitwise.band(h, 0x3FFF), @ftype_vp8}
  end

  defp parse_lossless(
         _first,
         <<one::size(8), two::size(8), three::size(8), four::size(8), _rest::binary>> =
           _buf
       ) do
    w = 1 + Bitwise.bor(Bitwise.<<<(Bitwise.band(two, 0x3F), 8), one)

    h =
      1 +
        Bitwise.bor(
          Bitwise.bor(Bitwise.<<<(Bitwise.band(four, 0xF), 10), Bitwise.<<<(three, 2)),
          Bitwise.>>>(Bitwise.band(two, 0xC0), 6)
        )

    {@mime, w, h, @ftype_vp8l}
  end

  defp parse_vp8xbitstream(
         <<_skip::size(24), canvas_w::little-size(24), canvas_h::little-size(24),
           _rest::binary>> = _buf
       ) do
    {@mime, canvas_w + 1, canvas_h + 1, @ftype_vp8x}
  end

  defp parse_vp8xbitstream(_), do: nil
end
