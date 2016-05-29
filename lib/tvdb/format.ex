defmodule Tvdb.Formatter do
  @doc """
  Formats a map of episodes into a pretty printable format
  """
  def ep_list(list) do
    Enum.map(list, &ep_string(&1))
    |> Enum.sort
  end

  defp ep_string(map) do
    season = Map.get(map, "airedSeason") |> num_pad
    ep = Map.get(map, "airedEpisodeNumber") |> num_pad
    epName = Map.get(map, "episodeName")

    {"S#{season}E#{ep} - #{epName}", Map.get(map, "id")}
  end

  defp num_pad(n) do
    n |> Integer.to_string |> String.rjust(2,?0)
  end
end
