defmodule Tvdb do
  use Application
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Tvdb.Auth, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :simple_one_for_one, name: Tvdb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def new do
    Supervisor.start_child(Tvdb.Supervisor, [])
    Tvdb.Connect.start
  end

 
end
