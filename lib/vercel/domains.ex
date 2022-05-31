defmodule Vercel.Domains do
  import Vercel.Http

  @endpoint "domains"

  @doc """
  Check if a domain name is available for purchase.
  """
  @spec status(params) :: {:ok, map()} | {:error, any()}
        when params: %{
               :name => String.t(),
               optional(:teamId) => String.t()
             }
  def status(params) do
    request(:get, "v4/" <> @endpoint <> "/status", params)
  end

  @doc """
  Check the price to purchase a domain and how long a single purchase period is.
  """
  @spec price(params) :: {:ok, map()} | {:error, any()}
        when params: %{
               :name => String.t(),
               optional(:teamId) => String.t(),
               optional(:type) => String.t()
             }
  def price(params) do
    request(:get, "v4/" <> @endpoint <> "/price", params)
  end

  @doc """
  Get information for a single domain in an account or team.
  """
  @spec info(String.t(), params) :: {:ok, map()} | {:error, any()}
        when params: %{
               optional(:teamId) => String.t()
             }
  def info(domain, params \\ %{}) do
    request(:get, "v5/" <> @endpoint <> "/" <> domain, params)
  end

  @doc """
  Retrieves a list of domains registered for the authenticating user. By default it returns the last 20 domains if no limit is provided.
  """
  @spec list(params) :: {:ok, map()} | {:error, any()}
        when params: %{
               optional(:limit) => integer(),
               optional(:since) => integer(),
               optional(:teamId) => String.t(),
               optional(:until) => integer()
             }
  def list(params \\ %{}) do
    request(:get, "v5/" <> @endpoint, params)
  end

  @doc """
  Allows to purchase the specified domain.
  """
  @spec buy(params, opts) :: {:ok, map()} | {:error, any()}
        when params: %{
               :name => String.t(),
               optional(:expectedPrice) => number(),
               optional(:renew) => boolean()
             },
             opts: %{
               optional(:teamId) => String.t()
             }
  def buy(params, opts \\ %{}) do
    request(:post, "v4/" <> @endpoint <> "/buy", params, opts)
  end
end
