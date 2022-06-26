defmodule Debug do
  @moduledoc """
  The module for debug.
  When you want to inspect the value of argument, this will be useful.
  """
  def debugtool(data, msg) do
    IO.inspect("↓↓↓----#{msg}----↓↓↓")
    IO.inspect(data)
    IO.inspect("↑↑↑----#{msg}----↑↑↑")
  end
end
