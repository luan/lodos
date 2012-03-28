require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Lodos
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        controller_specs: false,
        helper_specs: false
      g.assets false
      g.helpers false
      g.javascripts false
      g.styleshees false
    end

    config.time_zone = "Brasilia"
    config.i18n.default_locale = :'pt-BR'
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    
    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end
