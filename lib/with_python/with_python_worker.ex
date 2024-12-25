defmodule WithPython.Worker do
	use GenServer
	require Logger
#	@timeout 10_000
	def start_link do
		GenServer.start_link(__MODULE__, nil)
	end
	def start_link(_) do
		start_link()
	end
	def message(pid, message) do
		GenServer.call(pid, {:message, message})
	end
	def call(my_string) do
		Task.async(fn ->
			:poolboy.transaction(
				:python_worker,
				fn pid ->
					GenServer.call(pid, {:get_path, my_string})
				end
			)
		end)
	end
	def call2(my_string) do
		Task.async(fn ->
			:poolboy.transaction(
				:python_worker,
				fn pid ->
					GenServer.call(pid, {:change_path, my_string})
				end
			)
		end)
	end
	## callbacks
	@impl true
	def init(_) do
		path =
			[:code.priv_dir(:with_python), "python"] |> Path.join()
		with {:ok, pid} = :python.start([{:python_path, to_charlist(path)}, {:python, ~c'python3'}]) do
			Logger.info("[#{__MODULE__}] started python worker")
			{:ok, pid}
		end
	end
	@impl true
	def handle_call({:get_path, my_string}, _from, pid) do
		result = :python.call(pid, :optimize, :get_path, [my_string])
		Logger.info("[#{__MODULE__}] Handle call")
		{:reply, {:ok, result}, pid}
	end
	@impl true
	def handle_call({:change_path, my_string}, _from, pid) do
		result = :python.call(pid, :optimize, :change_path, [my_string])
		Logger.info("[#{__MODULE__}] Handle call")
		{:reply, {:ok, result}, pid}
	end
end
