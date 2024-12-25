defmodule WithPython.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: WithPython.Worker.start_link(arg)
      # {WithPython.Worker, arg}
			:poolboy.child_spec(:worker, python_poolboy_config())
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WithPython.Supervisor]
    Supervisor.start_link(children, opts)
  end
	def python_poolboy_config() do
		[
			{:name, {:local, :python_worker}},
			{:worker_module, WithPython.Worker},
			{:size, 1},
			{:max_overflow, 0}
		]
	end
end
