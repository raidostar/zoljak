require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Zoljak
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    ## devise : 이메일 인증 설정

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.default_url_options = { host: 'http://localhost:3000' }
    ActionMailer::Base.smtp_settings = {
      :address              => 'smtp.gmail.com',
      :domain               => 'mail.google.com',
      :port                 => 587,
      :user_name            => ENV["GOOGLE_EMAIL_ID"],
      :password             => ENV["GOOGLE_EMAIL_PASSWORD"],
      :authentication       => 'login',
      :enable_starttls_auto => true
    }
  end
end
