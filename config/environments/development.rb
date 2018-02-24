Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Check yarn integrity
  config.webpacker.check_yarn_integrity = true

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store                = :memory_store
    config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{2.day.second.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching       = false
  config.action_mailer.default_url_options   = AxisConfig.mailer.url_options.to_hash
  config.action_mailer.asset_host            = AxisConfig.mailer.asset_host
  config.action_mailer.delivery_method       = AxisConfig.mailer.delivery
  config.action_mailer.smtp_settings         = {
      :user_name            => AxisConfig.mailer.smtp.user_name,
      :password             => AxisConfig.mailer.smtp.password,
      :address              => AxisConfig.mailer.smtp.address,
      :domain               => AxisConfig.mailer.smtp.domain,
      :port                 => AxisConfig.mailer.smtp.port,
      :authentication       => AxisConfig.mailer.smtp.authentication,
      :enable_starttls_auto => true,
      :openssl_verify_mode  => OpenSSL::SSL::VERIFY_NONE # OpenSSL:SSL::VERIFY_PEER
  } if AxisConfig.mailer.delivery == :smtp

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
