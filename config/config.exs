# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix_postman,
  task_process_name: :phoenix_postman_master,
  docs_processor: &PhoenixPostman.DefaultProcessor.process_docs/1,
  docs_regex: ~r/^(?<title>[^\n]*)\n[^\n]*\n(?<description>.*)$/us,
  test_name_processor: &PhoenixPostman.DefaultProcessor.process_test_name/2,
  test_name_regex: ~r/\[(?<name>.*)\]/us

# Configures the endpoint
config :phoenix_postman, PhoenixPostmanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kkNssBQlJUk3XM8WKGcZJeSG38+Ad9MQPs33+ZD4PTjmvDqUEsMv2wTSWvM078hc",
  render_errors: [view: PhoenixPostmanWeb.ErrorView, accepts: ~w(json)]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
