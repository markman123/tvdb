defmodule Tvdb.Auth do
  @doc """
  Creates the bucket to hold the key value pair
  """
  def start_link  do
    Agent.start_link(fn -> %{} end, name: :auth)
  end

  @doc """
  Gets the value corresponding with `key`
  """

  def get(key) do
    Agent.get(:auth, &Map.get(&1, key))
  end

  @doc """
  Puts a new value / replaces an existing value at `key` with `value
  """
  
  def put(key,value) do
    Agent.update(:auth, &Map.put(&1,key,value))
  end

end
