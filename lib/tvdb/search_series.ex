defmodule Tvdb.Search do
  @moduledoc """
  Interface allowing search of series. There are 3 ways to search
  """

  @doc """
  Search a series with a string
  """
  def by_name(name) do
    search({:name,name})
  end
  @doc """
  Search by imdb id
  """
  def by_imdb(imdb_id) do
    search({:imdbId, imdb_id})
  end
  @doc """
  Search by zap2It id
  """
  def by_zap2it(zap_id) do
    search({:zap2itId, zap_id})
  end

  def withEpisodes(name) do
    first_result = by_name(name) |> List.first
    first_result["id"]
    |> Tvdb.Series.episodes
    
  end
  
  defp search({search_by, name}) do
    encoded_string = URI.encode_query(%{search_by => name})
    uri = "search/series?#{encoded_string}"
    Tvdb.Connect.get(uri)
    |> handle_series
  end

  defp handle_series({:ok, %HTTPoison.Response{body: body}}) do
    Map.get(body,"data")
  end
  
end
