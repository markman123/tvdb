defmodule Tvdb.Series do
  @moduledoc """
  Interface to look at information about series. Using the TVDb api
  """

  @doc """
  Get series information based on the id of the series
  To get the id, you can use the Tvdb.Search
  """
  def information(id) do
    hit_api(:information, id)
  end
  @doc """
  Get list of actors from the id of the series
  To get the id, you can use the Tvdb.Search
  """
  def actors(id) do
    hit_api(:actor, id)
  end
  @doc """
  Get list of episodes for series. TODO: Pagination
  To get the id, you can use the Tvdb.Search
  """
  def episodes(id) do
    hit_api(:episodes, id)
  end
  @doc """
  Get series summary of number of seasons, dvd's and episodes
  To get the id, you can use the Tvdb.Search
  """
  def summary(id) do
    hit_api(:summary, id)
  end
  @doc """
  Get image information (not working at the moment, due to query implementation)
  To get the id, you can use the Tvdb.Search
  """
  def images(id) do
    hit_api(:images, id)
  end
  @doc """
  Get summary of the volume of pictures available in the query
  To get the id, you can use the Tvdb.Search
  """  
  def image_summary(id) do
    hit_api(:image_summary, id)
  end
  @doc """
  Get detailed episode information, so the id is the episode id
  To get the id, you can use the Tvdb.Series.Episodes
  """
  def episode_information(ep_id) do
    hit_api(:episode, ep_id)
  end
  
  defp hit_api(type,id) do
    uri = case type do
	    :information   -> "series/#{id}"
	    :actor         -> "series/#{id}/actors"
	    :episodes      -> "series/#{id}/episodes"
	    :summary       -> "series/#{id}/episodes/summary"
	    :image_summary -> "series/#{id}/images"
	    :images        -> "series/#{id}/images/query"
	    :episode       -> "episodes/#{id}"
	  end
    Tvdb.Connect.get(uri)
    |> handle_series
  end
  
  defp handle_series({:ok, %HTTPoison.Response{body: body}}) do
    Map.get(body,"data")
  end

end
