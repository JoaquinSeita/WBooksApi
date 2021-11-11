require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Myapp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.available_locales = [:en, :es]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :en
  end
end
