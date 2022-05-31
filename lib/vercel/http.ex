defmodule Vercel.Http do
  use HTTPoison.Base

  def request(:get, url, params) do
    case get(url, [Authorization: "Bearer " <> access_token()], params: params) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body

      {:error, error} ->
        raise "Vercel.HttpClient error: #{error}"
    end
  end

  def request(:post, url, body_params, query_params) do
    case post(
           url,
           Poison.encode!(body_params),
           [Authorization: "Bearer " <> access_token(), "Content-Type": "application/json"],
           params: query_params
         ) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body

      {:error, error} ->
        raise "Vercel.HttpClient error: #{error}"
    end
  end

  defp access_token, do: Vercel.get_env(:access_token)

  def process_request_url(url) do
    "https://api.vercel.com/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
    |> atomize_keys()
    |> case do
      %{error: _} = r -> {:error, r}
      data -> {:ok, data}
    end
  end

  #######################################################
  ### Atomize Keys
  #######################################################

  @doc """
  Convert map string keys to :atom keys
  """
  defp atomize_keys(nil), do: nil

  defp atomize_keys(%{__struct__: _} = struct) do
    struct
  end

  defp atomize_keys(%{} = map) do
    map
    |> Enum.map(fn {k, v} -> {to_atom(k), atomize_keys(v)} end)
    |> Enum.into(%{})
  end

  defp atomize_keys([head | rest]) do
    [atomize_keys(head) | atomize_keys(rest)]
  end

  defp atomize_keys(not_a_map), do: not_a_map

  defp to_atom(str) when is_bitstring(str), do: String.to_atom(str)
  defp to_atom(str) when is_atom(str), do: str
end
