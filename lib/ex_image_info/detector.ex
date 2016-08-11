defmodule ExImageInfo.Detector do
  @moduledoc false

  @callback info() :: { mimetype :: String.t, width :: Integer.t, height :: Integer.t, variant :: String.t} | nil
  @callback type() :: { mimetype :: String.t, variant :: String.t} | nil
  @callback seems?() :: Boolean.t
end
