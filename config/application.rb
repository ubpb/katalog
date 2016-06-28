require File.expand_path("../boot", __FILE__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KatalogUbpb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add lib/ to autoload paths
    config.autoload_paths.concat([
      Rails.root.join("lib"),
      Rails.root.join("app", "services", "concerns")
    ])

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Berlin"

    # Locale setup
    I18n.backend = I18n::Backend::Advanced.new
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.i18n.default_locale = :de
    config.i18n.available_locales = [:de]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Setup the host to make full URLs work for the mailer.
    routes.default_url_options = {
      host: ENV["KATALOG_HOST"] || "localhost:3000"
    }
  end
end
