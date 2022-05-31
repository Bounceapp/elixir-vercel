defmodule Vercel.Projects do
  import Vercel.Http

  @endpoint "projects"

  @doc """
  Add a domain to the project by passing its domain name and by specifying the project by either passing the project id or name in the URL.
  If the domain is not yet verified to be used on this project, the request will return verified = false,
  and the domain will need to be verified according to the verification challenge via POST /projects/:idOrName/domains/:domain/verify.
  If the domain already exists on the project, the request will fail with a 400 status code.

  https://vercel.com/docs/rest-api#endpoints/projects/add-a-domain-to-a-project
  """
  @spec add_domain(String.t(), params, opts) :: {:ok, map()} | {:error, any()}
        when params: %{
               :name => String.t(),
               optional(:gitBranch) => String.t(),
               optional(:redirect) => String.t(),
               optional(:redirectStatusCode) => String.t()
             },
             opts: %{
               optional(:teamId) => String.t()
             }
  def add_domain(project, params, opts \\ %{}) do
    request(:post, "v9/" <> @endpoint <> "/" <> project <> "/domains", params, opts)
  end

  @doc """
  Attempts to verify a project domain with verified = false by checking the correctness of the project domain's verification challenge.

  https://vercel.com/docs/rest-api#endpoints/projects/verify-project-domain
  """
  @spec verify_domain(project :: String.t(), domain :: String.t(), opts) ::
          {:ok, map()} | {:error, any()}
        when opts: %{
               optional(:teamId) => String.t()
             }
  def verify_domain(project, domain, opts \\ %{}) do
    request(
      :post,
      "v9/" <> @endpoint <> "/" <> project <> "/domains/" <> domain <> "/verify",
      %{},
      opts
    )
  end
end
