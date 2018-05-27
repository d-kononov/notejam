# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :redis_session_store, {
    key: '_notejam_session',
    redis: {
        expire_after: 120.minutes,
        key_prefix: 'notejam:session:',
        url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/2",
    }
}
