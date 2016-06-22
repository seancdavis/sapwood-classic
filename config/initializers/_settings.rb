config_file = if File.exists?(File.join(Rails.root,'config','sapwood.yml'))
  File.join(Rails.root,'config','sapwood.yml')
else
  File.join(Rails.root,'config','taproot.yml')
end

contents = ERB.new(File.read(config_file)).result
SapwoodSetting = YAML.load(contents)[Rails.env].to_ostruct

if SapwoodSetting.site.secret_key.blank?
  raise "You must set a secret key for your app in your sapwood.yml file."
end
