defmodule ExImageInfo.Types.ICO do

  @moduledoc false

  @behaviour ExImageInfo.Detector
  # https://en.wikipedia.org/wiki/ICO_(file_format)

  @mime "image/x-icon"
  @ftype "ICO"

  @signature << 0::size(16), 0x01, 0x00 >> # 0x0100 -> little endian -> 1 (.ICO), 2 (.CUR)

  ## Public API

  def seems?(<< @signature, _rest::binary >>), do: true
  def seems?(_), do: false

  def info(<< @signature, num_images::little-size(16), rest::binary >>) do
    case parse(rest, num_images) do
      {w, h} -> {@mime, w, h, @ftype}
      _ -> nil
    end
  end
  def info(_), do: nil

  def type(<< @signature, _rest::binary >>), do: {@mime, @ftype}
  def type(_), do: nil

  ## Private

  defp parse(binary, num), do: parse(binary, num, {0, 0})
  defp parse(<< w::size(8), h::size(8), _head::bytes-size(14), rest::binary >>, num, {wp, hp} = acc) do
    w = if w == 0, do: 256, else: w
    h = if h == 0, do: 256, else: h
    sump = wp + hp
    sum = w + h
    acc = if sum > sump, do: {w, h}, else: acc
    if num == 1 do # last one
      acc
    else
      parse(rest, num - 1, acc)
    end
  end
  defp parse(_, _, _), do: nil

end
