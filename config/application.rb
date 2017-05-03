require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  end
end

#ログインページへとリダイレクトする前にapplication.html.hamlレイアウトが呼び出されてcurrent_userがnilエラーになるのを防ぐため、deviseのレイアウトファイルをdevise.html.hamlに変更
Rails.application.config.to_prepare do
  Devise::RegistrationsController.layout proc { |controller| user_signed_in? ? "application" : "devise" }
  # And/or Sessions, Confirmations, Unlocks, Passwords
end
