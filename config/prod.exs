use Mix.Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :codebeam_camp, CodebeamCampWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 80],
  url: [host: "www.codebeam.camp", port: 443],
  check_origin: [
    "http://www.codebeam.camp",
    "https://www.codebeam.camp"
  ],
  https: [
    :inet6,
    port: 443,
    cipher_suite: :strong,
    keyfile: "/etc/letsencrypt/live/www.codebeam.camp/privkey.pem",
    certfile: "/etc/letsencrypt/live/www.codebeam.camp/fullchain.pem"
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: ".",
  version: Application.spec(:codebeam_camp, :vsn)

# Do not print debug messages in production
config :logger, level: :info

config :codebeam_camp, CodebeamCampWeb.Endpoint,
  force_ssl: [rewrite_on: [:x_forwarded_proto], hsts: true, host: nil]

# ## SSL Support
#
# IMPORTANT NOTES:
# - Congratulations! Your certificate and chain have been saved at:
#   /etc/letsencrypt/live/www.codebeam.camp/fullchain.pem
#   Your key file has been saved at:
#   /etc/letsencrypt/live/www.codebeam.camp/privkey.pem
#   Your cert will expire on 2019-07-19. To obtain a new or tweaked
#   version of this certificate in the future, simply run certbot
#   again. To non-interactively renew *all* of your certificates, run
#   "certbot renew"
# - Your account credentials have been saved in your Certbot
#   configuration directory at /etc/letsencrypt. You should make a
#   secure backup of this folder now. This configuration directory will
#   also contain certificates and private keys obtained by Certbot so
#   making regular backups of this folder is ideal.
# - If you like Certbot, please consider supporting our work by:
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :codebeam_camp, CodebeamCampWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [
#         :inet6,
#         port: 443,
#         cipher_suite: :strong,
#         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#         certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
#       ]
#
# The `cipher_suite` is set to `:strong` to support only the
# latest and more secure SSL ciphers. This means old browsers
# and clients may not be supported. You can set it to
# `:compatible` for wider support.
#
# `:keyfile` and `:certfile` expect an absolute path to the key
# and cert in disk or a relative path inside priv, for example
# "priv/ssl/server.key". For all supported SSL configuration
# options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
#
# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
#     config :codebeam_camp, CodebeamCampWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases (distillery)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :codebeam_camp, CodebeamCampWeb.Endpoint, server: true
#
# Note you can't rely on `System.get_env/1` when using releases.
# See the releases documentation accordingly.

# Finally import the config/prod.secret.exs which should be versioned
# separately.

import_config "prod.secret.exs"
