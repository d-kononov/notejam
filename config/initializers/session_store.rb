# Be sure to restart your server when you modify this file.

Notejam::Application.config.session_store :redis_store, servers: ["redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/0/session"]
