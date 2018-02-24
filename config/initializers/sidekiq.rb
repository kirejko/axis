# frozen_string_literal: true

# In order to run several sidekiq services on the same machine
# services must be namespaced and pointed to different redis DBs
#
# IMPORTANT!!! Redis namespacing requires gem 'redis-namespace'
#
# config.redis = {
#     namespace: AxisConfig.sidekiq.redis.namespace,
#     url:       AxisConfig.sidekiq.redis.url
# }
#

require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = AxisConfig.sidekiq.redis.to_hash
end

Sidekiq.configure_client do |config|
  config.redis = AxisConfig.sidekiq.redis.to_hash
end
