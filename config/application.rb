require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CloudApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    config.eager_load_paths += %W[#{config.root}/lib]
    config.paths.add "spec", eager_load: false, autoload: false
    config.autoloader = :zeitwerk
    config.eager_load_paths.reject! { |path| path =~ /spec|test/ }
    if defined?(FactoryBot)
      FactoryBot.definition_file_paths = [] if Rails.env.development?
    end    
    config.after_initialize do
      FactoryBot.reload if Rails.env.test?
    end
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
