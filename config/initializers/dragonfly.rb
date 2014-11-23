require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "09195be7669c466300f9f7d29c812aa66555bb5dc290e225114c9195d1d8c9c4"

  url_format "/media/:site/images/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
