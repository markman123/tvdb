defmodule Tvdb.Connect do
  use HTTPoison.Base

  def process_url(url) do
    Application.get_env(:tvdb, :base_url) <> url
  end

  def process_response_body(body) do
    Poison.decode!(body)
  end

  def process_request_headers(headers) do

    headers ++ [{"content-type", "application/json"},
		{"accept", "application/json"},
	       {"Authorization", "Bearer #{auth}"}]
  end

  def auth do
    _auth Tvdb.Auth.get(:token)
  end

  defp _auth(nil) do
    "#{Application.get_env(:tvdb,:base_url)}login"
    |> HTTPoison.post(auth_body, [{"content-type","application/json"}])
    |> auth_response
  end

  defp _auth(token) do
    token
  end

  defp auth_response({:ok, %HTTPoison.Response{body: body}}) do
    {:ok, body_decode} = body |> Poison.decode
    token = Map.get(body_decode, "token")
    Tvdb.Auth.put(:token, token)
    token
  end
  
  defp auth_body do
    {:ok, body} = %{apikey: Application.get_env(:tvdb, :api_key),
		    username: Application.get_env(:tvdb, :user_name),
		    userkey: Application.get_env(:tvdb, :user_key)}
    |> Poison.encode

    body
  end

end


