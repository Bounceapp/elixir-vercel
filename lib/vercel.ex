defmodule Vercel do
  @moduledoc """
  An Elixir wrapper for Vercel's API. Only a subset of the API is
  supported and this is a work in progress. That said, any modules that have been implemented can be used.
  For general reference please see:
  https://vercel.com/docs/rest-api
  """

  defmodule ConfigError do
    @moduledoc """
    Raised at runtime when a config variable is missing.
    """

    defexception [:message]

    @doc """
    Build a new ConfigError exception.
    """
    @impl true
    def exception(value) do
      message = "missing config for :#{value}"

      %ConfigError{message: message}
    end
  end

  @doc """
  Convenience function for retrieving Vercel specfic environment values, but
  will raise an exception if values are missing.
  """
  @spec get_env(atom, any) :: any
  def get_env(key, default \\ nil) do
    case Application.fetch_env(:vercel, key) do
      {:ok, {:system, var}} when is_binary(var) ->
        fallback_or_raise(var, System.get_env(var), default)

      {:ok, value} ->
        value

      :error ->
        fallback_or_raise(key, nil, default)
    end
  end

  defp fallback_or_raise(key, nil, nil), do: raise(ConfigError, key)
  defp fallback_or_raise(_, nil, default), do: default
  defp fallback_or_raise(_, value, _), do: value
end
