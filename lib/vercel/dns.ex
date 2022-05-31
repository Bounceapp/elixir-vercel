defmodule Vercel.Dns do
  import Vercel.Http

  @endpoint "domains"

  @doc """
  Creates a DNS record for a domain.
  """
  @spec create(String.t(), params, opts) :: {:ok, map()} | {:error, any()}
        when params: %{
               :type => String.t(),
               :name => String.t(),
               :value => String.t()
             },
             opts: %{
               optional(:teamId) => String.t()
             }
  def create(domain, params, opts \\ %{}) do
    request(:post, "v2/" <> @endpoint <> "/" <> domain <> "/records", params, opts)
  end

  @doc """
  Retrieves a list of DNS records created for a domain name. By default it returns 20 records if no limit is provided. The rest can be retrieved using the pagination options.
  """
  @spec list(String.t(), params) :: {:ok, map()} | {:error, any()}
        when params: %{
               optional(:limit) => String.t(),
               optional(:since) => String.t(),
               optional(:teamId) => String.t(),
               optional(:until) => String.t()
             }
  def list(domain, params \\ %{}) do
    request(:get, "v4/" <> @endpoint <> "/" <> domain <> "/records", params)
  end

  @doc """
  Removes an existing DNS record from a domain name.
  """
  @spec delete(domain :: String.t(), record_id :: String.t(), params) ::
          {:ok, map()} | {:error, any()}
        when params: %{
               optional(:teamId) => String.t()
             }
  def delete(domain, record_id, params \\ %{}) do
    request(:delete, "v2/" <> @endpoint <> "/" <> domain <> "/records/" <> record_id, params)
  end
end
