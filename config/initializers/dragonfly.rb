require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret SapwoodSetting.dragonfly.secret

  url_format "/media/:job/:name"

  url_host SapwoodSetting.dragonfly.host

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
