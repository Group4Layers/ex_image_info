defmodule ExImageInfo.Types.TIFF do
  @moduledoc false

  @behaviour ExImageInfo.Detector
  # https://en.wikipedia.org/wiki/TIFF

  require Bitwise
  # import Bitwise, only: [:<<</2]

  @mime "image/tiff"
  @ftypeII "TIFFII"
  @ftypeMM "TIFFMM"

  # TODO: why it does not work bytes-size(3) ?
  @signature_ii << "II", 0x2A00::size(16) >>
  @signature_mm << "MM", 0x002A::size(16) >>

  # Public API

  def seems?(<< @signature_ii, _rest::binary >>), do: true
  def seems?(<< @signature_mm, _rest::binary >>), do: true
  def seems?(_), do: false

  def info(<< @signature_ii, rest::binary >>), do: parse_tiff(false, rest, 4 + byte_size rest)
  def info(<< @signature_mm, rest::binary >>), do: parse_tiff(true, rest, 4 + byte_size rest)
  def info(_), do: nil

  def type(<< @signature_ii, _rest::binary >>), do: {@mime, @ftypeII}
  def type(<< @signature_mm, _rest::binary >>), do: {@mime, @ftypeMM}
  def type(_), do: nil

  # Private

  # fsize = file size in bytes
  def parse_tiff(false = b_e, << idf_off::little-size(32), rest::binary >>, fsize) do
    parse_tiff_block(b_e, idf_off, rest, fsize)
  end
  def parse_tiff(true = b_e, << idf_off::size(32), rest::binary >>, fsize) do
    parse_tiff_block(b_e, idf_off, rest, fsize)
  end
  def parse_tiff(_, _, _), do: nil


  def parse_tiff_block(b_e, idf_off, rest, fsize) do
    buff_size = 1024
    buff_size = if (idf_off + buff_size) > fsize, do: fsize - idf_off - 10, else: buff_size
    idf_off_pos = idf_off - 4 - 4 # @signature_xx (4), idf_off::size(32) (4)
    case rest do
      # << _skip::bytes-size(idf_off_pos), _skip::bytes-size(2), buff_slice::bytes-size(buff_size), _::binary >> ->
        # TODO: why having _skip:: and _skip:: it just does not work, but does not emit an error?!
      # << _skip1::bytes-size(4), _skip2::bytes-size(2), buff_idf::bytes-size(buff_size), _::binary >> ->
      << _skip1::bytes-size(idf_off_pos), _skip2::bytes-size(2), buff_idf::bytes-size(buff_size), _::binary >> ->
        tags = parse_tiff_tags(b_e, buff_idf, %{})
        ftype = if b_e == false, do: @ftypeII, else: @ftypeMM
        w = Map.get(tags, 256)
        h = Map.get(tags, 257)
        if w != nil and h != nil, do: {@mime, w, h, ftype}, else: nil
      _ -> nil
    end
  end

  def parse_tiff_nexttags(<< _skip::bytes-size(12), rest::binary >>) do
    if byte_size(rest) > 12, do: rest, else: <<>>
  end
  def parse_tiff_nexttags(_rest), do: <<>>

  def parse_tiff_tags(_b_e, <<>>, tags) do
    tags
  end

  def parse_tiff_tags(true = b_e, << code::size(16), type::size(16), length::size(32), low::size(16), high::size(16), rest::binary >> = buff, tags) do
    parse_tiff_tags(b_e, code, type, length, low, high, rest, buff, tags)
  end
  def parse_tiff_tags(false = b_e, << code::little-size(16), type::little-size(16), length::little-size(32), low::little-size(16), high::little-size(16), rest::binary >> = buff, tags) do
    parse_tiff_tags(b_e, code, type, length, low, high, rest, buff, tags)
  end

  def parse_tiff_tags(b_e, code, type, length, low, high, << _rest::binary >>, buff, tags) do
    if code == 0 do
      tags
    else
      tags = if length == 1 and (type == 3 or type == 4) do
        val = (Bitwise.<<< high, 16) + low
        Map.put(tags, code, val)
      else
        tags
      end
      buff = parse_tiff_nexttags(buff)
      parse_tiff_tags(b_e, buff, tags)
    end
  end

  # # TODO: why if i replace in the function pattern matching 0xC2 with @signature_prog it does not work??
  # defp parse_tiff_sof(0xC0, next), do: parse_tiff_dimensions(@ftypeBase, next)
  # defp parse_tiff_sof(0xC2, next), do: parse_tiff_dimensions(@ftypeProg, next)
  # defp parse_tiff_sof(_, next), do: parse_tiff(next)

end
