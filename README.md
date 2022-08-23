# Vercel for Elixir [![Hex pm](https://img.shields.io/hexpm/v/vercel.svg?style=flat)](https://hex.pm/packages/vercel) [![hex.pm downloads](https://img.shields.io/hexpm/dt/vercel.svg?style=flat)](https://hex.pm/packages/vercel)

An Elixir wrapper for Vercel's API

# Installation

This package can be installed by adding `vercel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:vercel, "~> 0.1.6"}
  ]
end
```

# Configuration

To make calls to Vercel, it is necessary to configure your Vercel Access Token on your `config.exs` file:

```elixir
config :vercel, access_token: System.get_env("VERCEL_ACCESS_TOKEN")
# OR
config :vercel, access_token: "YOUR_TOKEN"
```

You can generate this token at https://vercel.com/account/tokens

# Documentation

The docs can be found at [https://hexdocs.pm/vercel](https://hexdocs.pm/vercel).

# License

More info at [LICENSE](LICENSE).
