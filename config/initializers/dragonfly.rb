require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret TaprootSetting.dragonfly.secret

  url_format "/media/:job/:name"

  if Rails.env.production?
    datastore :s3,
      :bucket_name          => TaprootSetting.aws.bucket,
      :access_key_id        => TaprootSetting.aws.access_key_id,
      :secret_access_key    => TaprootSetting.aws.secret_access_key,
      :url_scheme           => 'https'
  else
    datastore :file,
      :root_path => Rails.root.join('public/system/dragonfly', Rails.env),
      :server_root => Rails.root.join('public')
  end

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
