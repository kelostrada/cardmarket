# Cardmarket

Client library for https://cardmarket.com API.

## Installation

The package can be installed by adding `cardmarket` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cardmarket, "~> 0.1.0"}
  ]
end
```

The config with your app credentials is required: 

```elixir
config :cardmarket, :authorization, %{
  app_token: "xxx",
  app_secret: "yyy",
  access_token: "zzz",
  access_token_secret: "vvv"
}
```

Documentation: [https://hexdocs.pm/cardmarket](https://hexdocs.pm/cardmarket).

