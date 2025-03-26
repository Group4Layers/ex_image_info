# Used by "mix format"
[
  plugins: [Styler],
  inputs: [
    "{mix,.formatter}.exs",
    "{lib,bench}/**/*.{ex,exs}"
    | ["test/**/*.{ex,exs}"]
      |> Enum.flat_map(&Path.wildcard(&1, match_dot: true))
      |> Kernel.--(["test/ex_image_info_test/mocks/isobmff_test.exs"])
  ],
  line_length: 88
]
