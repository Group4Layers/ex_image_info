defmodule ExImageInfo.Detector do
  @moduledoc false

  @callback info(binary) ::
              {mimetype :: String.t(), width :: integer(), height :: integer(),
               variant :: String.t()}
              | nil
  @callback type(binary) :: {mimetype :: String.t(), variant :: String.t()} | nil
  @callback seems?(binary) :: boolean()
end
