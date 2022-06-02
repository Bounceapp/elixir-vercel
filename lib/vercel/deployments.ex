defmodule Vercel.Deployments do
  import Vercel.Http

  @endpoint "deployments"

  @doc """
  Create a new deployment with all the required and intended data. If the deployment is not a git deployment, all files must be provided with the request, either referenced or inlined.
  You can pass other params as referenced in https://vercel.com/docs/rest-api#endpoints/deployments/create-a-new-deployment
  """
  @spec create(params, opts) :: {:ok, map()} | {:error, any()}
        when params: %{
               :name => String.t(),
               optional(:gitSource) => %{
                 :org => String.t(),
                 :repo => String.t(),
                 :type => String.t(),
                 :ref => String.t()
               }
             },
             opts: %{
               optional(:teamId) => String.t(),
               optional(:skipAutoDetectionConfirmation) => String.t(),
               optional(:forceNew) => String.t()
             }
  def create(params, opts \\ %{}) do
    request(:post, "v13/" <> @endpoint, params, opts)
  end
end
