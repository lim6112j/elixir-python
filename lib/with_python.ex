defmodule WithPython do
  @moduledoc """
  Documentation for `WithPython`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> WithPython.hello()
      :world

  """
  def hello do
		path = [:code.priv_dir(:with_python), "python"] |> Path.join()
		{:ok, pid} = :python.start([{:python_path, to_charlist(path)}, {:python, ~c'python3'}])
		json_string = "getting path"
		_result = :python.call(pid,:optimize, :get_path, [json_string])
		# IO.puts(result)
		result2 = :python.call(pid,:optimize, :change_path, [])
		#IO.puts(result2)
		_final_result = List.to_string(result2)
  end
end
