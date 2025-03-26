defmodule ExImageInfo.Types.ISOBMFF do
  @moduledoc "HEIF, HEIC and AVIF image format parser"

  # There are code regions that cannot be tested as no fixtures/images to be validated against.
  # Returning nil to avoid failing, but ideally this format should have more image files.
  @unimplemented nil
  @malformed nil

  defmodule State do
    @moduledoc false
    defstruct index: 0,
              rotation: 0,
              primary_box: nil,
              ipma_boxes: [],
              ispe_boxes: [],
              readable_bytes: nil

    @type t :: %__MODULE__{
            rotation: integer(),
            index: integer(),
            primary_box: integer() | nil,
            ipma_boxes: list(),
            ispe_boxes: list(),
            readable_bytes: integer() | nil
          }

    def readable_bytes?(state) do
      state.readable_bytes == nil || state.readable_bytes > 0
    end

    def update_readable_bytes(state, size) when size < 0 do
      if state.readable_bytes == nil do
        state
      else
        %{state | readable_bytes: state.readable_bytes + size}
      end
    end

    def update_readable_bytes(state, readable_bytes),
      do: %{state | readable_bytes: readable_bytes}

    def update_index(state, value \\ nil) do
      value = if value == nil, do: state.index + 1, else: value
      %{state | index: value}
    end

    def ispe_box(state, width, height) do
      %{state | ispe_boxes: [{state.index, {width, height}} | state.ispe_boxes]}
    end

    def ipma_box(state, id, property_idx) do
      %{state | ipma_boxes: [{id, property_idx} | state.ipma_boxes]}
    end
  end

  @doc """
  Parses the binary to get the image size (ISOBMFF spec)
  """
  def parse_image_size(<<bin::binary>>), do: parse_box(bin, %State{})

  defp parse_box(<<rest::binary>>, state) do
    if State.readable_bytes?(state) do
      case read_box_header(rest, state) do
        {type, size, rest, state} -> handle_box(type, size, rest, state)
        malformed -> malformed
      end
    else
      @malformed
    end
  end

  defp read_box_header(
         <<0x01::size(32), type::binary-size(4), extended_size::size(64),
           rest::binary>>,
         state
       ) do
    # 4 bytes for size field, 4 bytes for type field, 8 bytes for extended size
    header_size = 4 + 4 + 8
    state = State.update_readable_bytes(state, -header_size)

    box_size = extended_size - header_size
    {type, box_size, rest, state}
  end

  defp read_box_header(<<size::size(32), type::binary-size(4), rest::binary>>, state) do
    # 4 bytes for size field, 4 bytes for type field
    header_size = 4 + 4
    state = State.update_readable_bytes(state, -header_size)

    box_size = size - header_size
    {type, box_size, rest, state}
  end

  defp read_box_header(_malformed_binary, _state), do: @malformed

  defp handle_box("ftyp", size, <<rest::binary>>, state) do
    case rest do
      <<_::binary-size(size), rest::binary>> ->
        state =
          state
          |> State.update_readable_bytes(-size)
          |> State.update_index()

        parse_box(rest, state)

      _ ->
        @malformed
    end
  end

  defp handle_box("meta", size, <<_rest::binary>>, _state) when size < 4,
    do: @unimplemented

  defp handle_box("meta", size, <<_::binary-size(4), rest::binary>>, state) do
    max = size - 4

    state =
      state
      |> State.update_readable_bytes(max)
      |> State.update_index(0)

    with %State{primary_box: pbox} = state <- parse_box(rest, state),
         # not pitm box
         false <- is_nil(pbox) do
      primary_indices =
        state.ipma_boxes
        |> Stream.filter(fn {id, _} -> id == pbox end)
        |> Stream.map(&elem(&1, 1))
        |> Enum.reverse()

      ispe_box =
        state.ispe_boxes
        |> Enum.reverse()
        |> Enum.find(fn {idx, _} -> idx in primary_indices end)

      case ispe_box do
        {_idx, {width, height}} ->
          if state.rotation in [90, 270] do
            {height, width}
          else
            {width, height}
          end

        _ ->
          # wrong primary_box assignation
          @malformed
      end
    end
  end

  defp handle_box("hdlr", size, <<rest::binary>>, state) when size >= 12 do
    case rest do
      <<_::binary-size(8), "pict", _::binary-size(size - 8 - 4), rest::binary>> ->
        state =
          state
          |> State.update_readable_bytes(-size)
          |> State.update_index()

        parse_box(rest, state)

      <<_::binary-size(size), _rest::binary>> ->
        @unimplemented

      _ ->
        @malformed
    end
  end

  defp handle_box("hdlr", _size, <<_rest::binary>>, _state), do: @unimplemented

  defp handle_box("pitm", size, <<rest::binary>>, state) do
    case rest do
      <<_::binary-size(4), pbox::size(16), _::binary-size(size - 4 - 2), rest::binary>> ->
        state =
          %{state | primary_box: pbox}
          |> State.update_readable_bytes(-size)
          |> State.update_index()

        parse_box(rest, state)

      _ ->
        @malformed
    end
  end

  # box types found in all images tested:
  #
  #     @skippable [
  #       "iloc",
  #       "iinf",
  #       "hvcC",
  #       "clap",
  #       "pixi",
  #       "iref",
  #       "dinf",
  #       "colr",
  #       "auxC",
  #       "mdat",
  #       # Mac Preview App - rotate - export as heic generates this box:
  #       "clli",
  #       # avif
  #       "pasp",
  #       "av1C"
  #     ]
  #     defp handle_box(skippable, size, <<rest::binary>>, state)
  #          when skippable in @skippable do
  #       case rest do
  #         <<_::binary-size(size), rest::binary>> ->
  #           state = state |> State.update_readable_bytes(-size) |> State.update_index()
  #           parse_box(rest, state)
  #
  #         _ ->
  #           @malformed
  #       end
  #     end
  #
  # to increase robustness, changing the spec to accept any type, moving to the bottom of `handle_box` functions

  @nestable ["iprp", "ipco"]
  defp handle_box(nestable, _size, <<rest::binary>>, state)
       when nestable in @nestable do
    parse_box(rest, State.update_index(state, 0))
  end

  defp handle_box("ispe", size, <<rest::binary>>, state) when size >= 12 do
    case rest do
      <<_::binary-size(4), width::size(32), height::size(32), _::binary-size(size - 12),
        rest::binary>> ->
        state =
          state
          |> State.update_readable_bytes(-size)
          |> State.ispe_box(width, height)
          |> State.update_index()

        parse_box(rest, state)

      <<_::binary-size(size), _rest::binary>> ->
        @unimplemented

      _ ->
        @malformed
    end
  end

  defp handle_box("ispe", _size, <<_rest::binary>>, _state), do: @unimplemented

  defp handle_box(
         "ipma",
         _size,
         <<_::binary-size(3), flags3::size(8), entries::size(32), rest::binary>>,
         state
       ) do
    state = State.update_readable_bytes(state, -8)
    flags3? = Bitwise.band(flags3, 0b00000001) == 1

    {_rest, state} =
      Enum.reduce(0..(entries - 1)//1, {rest, state}, fn _i, {rest, state} ->
        read_ipma_entry(rest, flags3?, state)
      end)

    state
  end

  defp handle_box("irot", size, <<rotation::size(8), rest::binary>>, state) do
    state = State.update_readable_bytes(state, -size)
    rotation = Bitwise.band(rotation, 0x3) * 90
    state = State.update_index(%{state | rotation: rotation})
    parse_box(rest, state)
  end

  defp handle_box("jxlc", _size, <<_rest::binary>>, _state), do: @unimplemented

  defp handle_box(_skippable, size, <<rest::binary>>, state) do
    case rest do
      <<_::binary-size(size), rest::binary>> ->
        state = state |> State.update_readable_bytes(-size) |> State.update_index()
        parse_box(rest, state)

      _ ->
        @malformed
    end
  end

  defp read_ipma_entry(
         <<id::size(16), essen_count::size(8), rest::binary>>,
         flags3?,
         state
       ) do
    state = State.update_readable_bytes(state, -3)

    Enum.reduce(0..(essen_count - 1)//1, {rest, state}, fn _i, {rest, state} ->
      read_ipma_essen_entry(id, rest, flags3?, state)
    end)
  end

  defp read_ipma_essen_entry(
         id,
         <<property_idx::size(8), property_idx_add::size(8), rest::binary>>,
         true = _flags3?,
         state
       ) do
    state = State.update_readable_bytes(state, -2)
    property_idx = Bitwise.band(property_idx, 0x7F)
    property_idx = Bitwise.<<<(property_idx, 7) + property_idx_add
    {rest, State.ipma_box(state, id, property_idx - 1)}
  end

  defp read_ipma_essen_entry(id, <<property_idx::size(8), rest::binary>>, false, state) do
    state = State.update_readable_bytes(state, -1)
    property_idx = Bitwise.band(property_idx, 0x7F)
    {rest, State.ipma_box(state, id, property_idx - 1)}
  end
end
