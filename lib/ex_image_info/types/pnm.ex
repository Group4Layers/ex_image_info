defmodule ExImageInfo.Types.PNM do
  @moduledoc false

  @behaviour ExImageInfo.Detector
  # https://en.wikipedia.org/wiki/Netpbm_format

  # promote to 3 mime types? (x-portable-bitmap, x-portable-graymap, x-portable-pixmap)
  @mime "image/x-portable-anymap"

  @ftype_pbm "PNMpbm"
  @ftype_pgm "PNMpgm"
  @ftype_ppm "PNMppm"

  @signature <<"P">>

  @sharp 0x23
  @nl 0x0A
  @space 0x20

  ## Public API

  def seems?(<<@signature, char::size(8), split, _rest::binary>>)
      when split in [@nl, @space, @sharp] do
    if signature_pnm(char), do: true, else: false
  end

  def seems?(_), do: false

  def info(<<@signature, char::size(8), split, rest::binary>>)
      when split in [@nl, @space, @sharp] do
    with type when not is_nil(type) <- signature_pnm(char),
         {w, h} <- parse(rest, nil) do
      {@mime, String.to_integer(w), String.to_integer(h), type}
    else
      _ -> nil
    end
  end

  def info(_), do: nil

  def type(<<@signature, char::size(8), split, _rest::binary>>)
      when split in [@nl, @space, @sharp] do
    case signature_pnm(char) do
      nil -> nil
      type -> {@mime, type}
    end
  end

  def type(_), do: nil

  ## Private

  defp signature_pnm(char) do
    case char do
      x when x in [?1, ?4] -> @ftype_pbm
      x when x in [?2, ?5] -> @ftype_pgm
      x when x in [?3, ?6] -> @ftype_ppm
      _ -> nil
    end
  end

  defp parse(rest, pre) do
    # no global
    case :binary.split(rest, "\n") do
      [line, next] ->
        # comments
        valid = hd(:binary.split(line, "#"))
        ret = Regex.run(~r/^\s*(\d+)(?:[\s]|)(?:(\d+)(?:[\s]|))?/, valid)

        case ret do
          [_, w, h] ->
            if pre == nil do
              {w, h}
            else
              {pre, w}
            end

          [_, w] ->
            if pre == nil do
              parse(next, w)
            else
              {pre, w}
            end

          _ ->
            parse(next, pre)
        end

      _ ->
        nil
    end
  end
end
