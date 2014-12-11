config_file = File.join(Rails.root,'config','taproot.yml')
if File.exists?(config_file)
  TaprootSetting = YAML.load_file(config_file)[Rails.env].to_ostruct
else
  raise "Can't find file: #{config_file}"
end
