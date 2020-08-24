defmodule Cardmarket.Middleware.Authorization do
  @moduledoc """
  Put Authorization header to request
  """

  @behaviour Tesla.Middleware

  def call(env, next, _options) do
    config = Application.fetch_env!(:cardmarket, :authorization)

    env
    |> Tesla.put_header("Authorization", authorization_header(env, config))
    |> Tesla.run(next)
  end

  def authorization_header(env, config) do
    params = [
      {"oauth_consumer_key", config.app_token},
      {"oauth_token", config.access_token},
      {"oauth_nonce", UUID.uuid4(:hex)},
      {"oauth_timestamp", timestamp()},
      {"oauth_signature_method", "HMAC-SHA1"},
      {"oauth_version", "1.0"}
    ]

    params =
      params
      |> List.insert_at(6, {"realm", env.url})
      |> List.insert_at(7, {"oauth_signature", calculate_signature(env, params, config)})
      |> Enum.map(fn {key, value} -> "#{key}=\"#{value}\"" end)
      |> Enum.join(", ")

    "OAuth #{params}"
  end

  defp timestamp() do
    DateTime.utc_now()
    |> DateTime.to_unix()
    |> to_string()
  end

  defp calculate_signature(env, params, config) do
    method = env.method |> to_string() |> String.upcase()
    escaped_url = URI.encode_www_form(env.url)
    query = Enum.map(env.query, fn {key, value} -> {to_string(key), to_string(value)} end)

    headers =
      params
      |> Kernel.++(query)
      |> Enum.sort(fn {key1, _}, {key2, _} -> key1 < key2 end)
      |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
      |> Enum.join("&")

    base = "#{method}&#{escaped_url}&#{URI.encode_www_form(headers)}"

    signature_key = "#{config.app_secret}&#{config.access_token_secret}"

    :crypto.hmac(:sha, signature_key, base) |> Base.encode64()
  end
end
