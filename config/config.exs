import Config

config :logger, :console,
  metadata: [:error_code, :mfa]
