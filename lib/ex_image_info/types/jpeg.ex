defmodule ExImageInfo.Types.JPEG do
  @moduledoc false

  @behaviour ExImageInfo.Detector
  # https://en.wikipedia.org/wiki/JPEG

  @mime "image/jpeg"
  @ftypeBase "baseJPEG"
  @ftypeProg "progJPEG"

  # TODO: why it does not work bytes-size(3) ?
  @signature << 0xFFD8::size(16) >>
  @signature_base << 0xC0 >>
  @signature_prog << 0xC2 >>


  # Public API
  def seems?(<< @signature, _rest::binary >>), do: true
  def seems?(_), do: false

  def info(<< @signature, _::size(16), rest::binary >>), do: parse_jpeg(rest)
  def info(_), do: nil

  def type(bin) do
    case info(bin) do
      {mime, _, _, ftype} -> {mime, ftype}
      _ -> nil
    end
  end

  # Private
  defp parse_jpeg(<< block_len::size(16), rest::binary >>) do
    parse_jpeg_block(block_len, rest)
  end
  defp parse_jpeg(_), do: nil

  defp parse_jpeg_block(block_len, << rest::binary >>) do
    block_len = block_len - 2 # bytes of block_len
    case rest do
      << _::bytes-size(block_len), 0xFF, sof::size(8), next::binary >> -> parse_jpeg_sof(sof, next)
      _ -> nil
    end
  end
  defp parse_jpeg_block(_, _), do: nil

  # TODO: why if i replace in the function pattern matching 0xC2 with @signature_prog it does not work??
  defp parse_jpeg_sof(0xC0, next), do: parse_jpeg_dimensions(@ftypeBase, next)
  defp parse_jpeg_sof(0xC2, next), do: parse_jpeg_dimensions(@ftypeProg, next)
  defp parse_jpeg_sof(_, next), do: parse_jpeg(next)

  defp parse_jpeg_dimensions(ftype, << _skip::size(24), height::size(16), width::size(16), _::binary >>) do
    {@mime, width, height, ftype}
  end
  defp parse_jpeg_dimensions(_, _), do: nil

end
