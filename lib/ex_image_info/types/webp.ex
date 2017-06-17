defmodule ExImageInfo.Types.WEBP do
  @moduledoc false

  @behaviour ExImageInfo.Detector

  require Bitwise

  @mime "image/webp"
  @ftypeVP8 "webpVP8"
  @ftypeVP8L "webpVP8L" # lossless

  @signature_riff <<"RIFF">>
  @signature_webp <<"WEBP">>
  @signature_vp8 <<"VP8">>
  # @signature_vp8l <<"VP8L">>

  def seems?(<< @signature_riff, _skip::bytes-size(4), @signature_webp, @signature_vp8, _rest::binary >>), do: true
  def seems?(_), do: false

  def info(<< @signature_riff, _skip::bytes-size(4), @signature_webp, @signature_vp8, lossy::bytes-size(1), _skip2::bytes-size(4), first::bytes-size(1), next::bytes-size(9), _rest::binary >>) do
    << _skip::bytes-size(2), sign::bytes-size(3), _::binary >> = next
    cond do
      lossy == " " and first != 0x2f -> parse_lossy(first, next)
      lossy == "L" and sign != << 0x9d012a::size(24) >> -> parse_lossless(first, next)
      true -> nil
    end
  end
  def info(_), do: nil

  defp parse_lossy(_first, << _skip::bytes-size(5), w::little-size(16), h::little-size(16), _rest::binary >>) do
    {@mime, Bitwise.band(w, 0x3fff), Bitwise.band(h, 0x3fff), @ftypeVP8}
  end

  defp parse_lossless(_first, << one::size(8), two::size(8), three::size(8), four::size(8), _rest::binary >> = _buf) do
    w = 1 + Bitwise.bor(Bitwise.<<<(Bitwise.band(two, 0x3f), 8), one)
    h = 1 + Bitwise.bor(Bitwise.bor(Bitwise.<<<(Bitwise.band(four, 0xf), 10), Bitwise.<<<(three, 2)), Bitwise.>>>(Bitwise.band(two, 0xC0), 6))
    {@mime, w, h, @ftypeVP8L}
  end

  def type(<< @signature_riff, _skip::bytes-size(4), @signature_webp, @signature_vp8, lossy::bytes-size(1), _rest::binary >>) do
    if lossy == "L", do: {@mime, @ftypeVP8L}, else: {@mime, @ftypeVP8}
  end
  def type(_), do: nil

end
