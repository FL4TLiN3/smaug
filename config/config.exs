# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :smaug, Smaug.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "3VLji5Q53pqTf2rRRYCy5gD1Itlmtv0g2X/jet0GDg2tuy5I/C70HUbfw2810Uhl",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Smaug.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :smaug,
  hash_salt: "4368458F0ECDA1D2B84D19A8E5391DE13E918203C5E94F79345C97F58E98758D",
  feeds: [
    "http://tabi-labo.com/feed/",
    "http://japanese.engadget.com/rss.xml",
    "http://feed.rssad.jp/rss/gigazine/rss_atom"
  ]

config :exq,
  host: "localhost",
  port: 6379,
  namespace: "exq"

