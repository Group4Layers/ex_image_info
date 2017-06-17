defmodule ExImageInfo.Types.PNM do
  @moduledoc false

  @behaviour ExImageInfo.Detector
  # https://en.wikipedia.org/wiki/Netpbm_format

  # promote to 3 mime types? (x-portable-bitmap, x-portable-graymap, x-portable-pixmap)
  @mime "image/x-portable-anymap"

  @ftypePBM "PNMpbm"
  @ftypePGM "PNMpgm"
  @ftypePPM "PNMppm"

  @signature << "P" >>

  # 0x23 = 35 = #
  @sharp 0x23
  @nl 0x0a
  @space 0x20

  # Public API
  def seems?(<< @signature, char::size(8), split, _rest::binary >>) when split in [@nl, @space, @sharp] do
    if signature_pnm(char), do: true, else: false
  end
  def seems?(_), do: false

  def info(<< @signature, char::size(8), split, rest::binary >>) when split in [@nl, @space, @sharp] do
    # Binary only
    # with type <- signature_pnm(char),
    #      {pos, _} <- :binary.match(rest, "\n"),
    #        line <- :binary.part(rest, {0, pos}),
    #        [_, w, h] <- Regex.run(~r/(\d+) (\d+)/, line) do
    #   {@mime, String.to_integer(w), String.to_integer(h), type}
    # else
    #     val -> IO.inspect val
    #   _ -> nil
    # end
    with type <- signature_pnm(char),
         {w, h} <- parse(rest, nil) do
      {@mime, String.to_integer(w), String.to_integer(h), type}
    else
      _ -> nil
    end

  end
  def info(_), do: nil


  def type(<< @signature, char::size(8), split, _rest::binary >>) when split in [@nl, @space, @sharp] do
    case signature_pnm(char) do
      nil -> nil
      type -> {@mime, type}
    end
  end
  def type(_), do: nil

  # Private

  defp signature_pnm(char) do
    case char do
      x when x in [?1, ?4] -> @ftypePBM
      x when x in [?2, ?5] -> @ftypePGM
      x when x in [?3, ?6] -> @ftypePPM
      _ -> nil
    end
  end

  defp parse(rest, pre) do
    with [line, next] <- :binary.split(rest, "\n"), # no global
    valid <- :binary.split(line, "#") |> hd, # comments
    ret <- Regex.run(~r/^\s*(\d+)(?:[\s]|)(?:(\d+)(?:[\s]|))?/, valid) do
      case ret do
        [_, w, h] ->
          if pre != nil do
            {pre, w}
          else
            {w, h}
          end
        [_, w] ->
          if pre != nil do
            {pre, w}
          else
            parse(next, w)
          end
        _ -> parse(next, pre)
      end
    else
      _ -> nil
    end
  end
end
