# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
                                       :key => SapwoodSetting.site.session_key

if SapwoodSetting.site.session_key.blank?
  raise "You must set a session key for your app in your sapwood.yml file."
end
