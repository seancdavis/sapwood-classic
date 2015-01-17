ActionMailer::Base.default_url_options = { :host => TaprootSetting.site.url }

if Rails.env.development?
  # use mailcatcher in development (http://mailcatcher.me/)
  ActionMailer::Base.smtp_settings = {
    :address => '127.0.0.1',
    :port => 1025
  }
else
  ActionMailer::Base.smtp_settings = {
    :user_name => TaprootSetting.mailer.user_name,
    :password => TaprootSetting.mailer.password,
    :domain => TaprootSetting.mailer.domain,
    :address => TaprootSetting.mailer.address,
    :port => TaprootSetting.mailer.port,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end
