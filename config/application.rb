require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    # デフォルトで日本語標記に
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # validationでレコード作成弾いた時に自動生成される<div class="field_with_errors"></div>を停止させるため
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      %Q(#{html_tag}).html_safe
    end
    # carrierwaveなどuploaderのクラスを使用可能に
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
  end
end
